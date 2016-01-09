//
//  NodeCell.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-03.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit
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

class NodeCell: UITableViewCell {
	
	private let label = UILabel()
	private let theme = DefaultTheme()
	private var leadingConstraint: NSLayoutConstraint!
	
	override var indentationLevel: Int {
		didSet {
			leadingConstraint.constant = CGFloat(indentationLevel) * indentationWidth
			setNeedsLayout()
		}
	}
	
	override var indentationWidth: CGFloat {
		didSet {
			leadingConstraint.constant = CGFloat(indentationLevel) * indentationWidth
			setNeedsLayout()
		}
	}
	
	var node: XMLElement? {
		didSet { render() }
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		setup()
		render()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		node = nil
	}
	
	private func setup() {
		contentView.addSubviewsForAutolayout(label)
		
		selectedBackgroundView = UIView(backgroundColor: Colors.grayLight)
		
		label.numberOfLines = 0
		label.font = UIFont(name: "Menlo-Regular", size: 14.0)
		label.lineBreakMode = .ByWordWrapping
		
		contentView.preservesSuperviewLayoutMargins = false
		contentView.layoutMargins = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
		
		let layoutMarginsGuide = contentView.layoutMarginsGuide
		leadingConstraint = label.leadingAnchor.constraintEqualToAnchor(layoutMarginsGuide.leadingAnchor)
		
		NSLayoutConstraint.activateConstraints([
			leadingConstraint,
			label.trailingAnchor.constraintEqualToAnchor(layoutMarginsGuide.trailingAnchor),
			label.topAnchor.constraintEqualToAnchor(layoutMarginsGuide.topAnchor),
			label.bottomAnchor.constraintEqualToAnchor(layoutMarginsGuide.bottomAnchor)
		])
	}
	
	private func render() {
		guard let node = node else {
			label.attributedText = nil
			indentationLevel = 0
			return
		}
		
		indentationLevel = node.depth
		label.attributedText = theme.attributedStringForTokenList(node.tokenList)
	}
	
}
