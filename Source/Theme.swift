//
//  Theme.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-05.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

protocol Theme {
	func fontAttributesForScope(scope: Scope) -> [String: AnyObject]
}

enum Scope {
	case Tag, AttributeName, AttributeValue
}

struct DefaultTheme: Theme {
	let colorDictionary: [Scope: UIColor] = [
		.Tag: Colors.blue,
		.AttributeName: Colors.gray,
		.AttributeValue: Colors.green
	]
	
	func fontAttributesForScope(scope: Scope) -> [String: AnyObject] {
		var attributes: [String: AnyObject] = [:]
		
		if let color = colorDictionary[scope] {
			attributes[NSForegroundColorAttributeName] = color
		}
		
		return attributes
	}
}



struct Token {
	let content: String
	let scope: Scope?
	
	init(content: String) {
		self.content = content
		self.scope = nil
	}
	
	init(content: String, scope: Scope) {
		self.content = content
		self.scope = scope
	}
}

extension Theme {
	func attributedStringForTokenList(tokens: [Token]) -> NSAttributedString {
		let string = NSMutableAttributedString()
		
		tokens.forEach { token in
			if let scope = token.scope {
				string.appendAttributedString(NSAttributedString(string: token.content, attributes: fontAttributesForScope(scope)))
			} else {
				string.appendAttributedString(NSAttributedString(string: token.content))
			}
		}
		
		return string
	}
}
