//
//  XMLElement+Extensions.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-14.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import Fuzi

extension XMLElement {
	var depth: Int {
		var depth = -1
		var node: XMLElement? = self
		
		while node?.parent != nil {
			node = node?.parent
			depth += 1
		}
		
		return depth
	}
	
	var uniqueSelector: String {
		if let id = attributes["id"] { return "#\(id)" }
		
		var parent = self.parent
		if parent == nil || tag == "html" { return "html" }
		
		var selector = "\(tag!):nth-child(\(indexInSiblings + 1))"
		while let theParent = parent, parentTag = theParent.tag where parentTag != "html" {
			if let id = theParent.attributes["id"] {
				return "#\(id) > \(selector)"
			}
			
			selector = "\(parentTag):nth-child(\(theParent.indexInSiblings + 1)) > \(selector)"
			parent = theParent.parent
		}
		
		return "html > \(selector)"
	}
	
	private var indexInSiblings: Int {
		guard let parent = self.parent else { return 0 }
		return parent.children.indexOf(self)!
	}
	
	var isEmpty: Bool {
		return children.isEmpty
	}
	
	var tokenList: [Token] {
		var tokens = [Token(content: "<\(tag!)", scope: .Tag)]
		
		attributes.forEach { attribute, value in
			tokens.appendContentsOf([
				Token(content: " \(attribute)=", scope: .AttributeName),
				Token(content: "\"\(value)\"", scope: .AttributeValue)
				])
		}
		
		tokens.append(Token(content: children.isEmpty ? " />" : ">", scope: .Tag))
		
		return tokens
	}
}
