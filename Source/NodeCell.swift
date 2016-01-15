//
//  NodeCell.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-03.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit
import Fuzi

protocol NodeCellDelegate: class {
	func nodeCellDidTapDisclosureIndicator(nodeCell: NodeCell)
}

class NodeCell: UITableViewCell {
	
	struct Constants {
		static let disclosureIndicatorSpacing: CGFloat = 5
	}
	
	private let label = UILabel()
	private let layoutView = UIStackView(axis: .Horizontal, spacing: Constants.disclosureIndicatorSpacing)
	private let disclosureIndicator = DisclosureIndicator()
	
	var expanded: Bool = false {
		didSet {
			guard oldValue != expanded else { return }
			render()
		}
	}
	
	weak var delegate: NodeCellDelegate?
	
	private let theme = DefaultTheme()
	private var leadingConstraint: NSLayoutConstraint?
	
	override var indentationLevel: Int {
		didSet {
			guard oldValue != indentationLevel else { return }
			leadingConstraint?.constant = CGFloat(indentationLevel) * indentationWidth
			setNeedsLayout()
		}
	}
	
	override var indentationWidth: CGFloat {
		didSet {
			guard oldValue != indentationWidth else { return }
			leadingConstraint?.constant = CGFloat(indentationLevel) * indentationWidth
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
		selectedBackgroundView = UIView(backgroundColor: Colors.grayLight)
		
		label.numberOfLines = 0
		label.font = UIFont(name: "Menlo-Regular", size: 14.0)
		label.lineBreakMode = .ByWordWrapping
		
		contentView.addSubviewsForAutolayout(layoutView)
		leadingConstraint = layoutView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor)
		
		NSLayoutConstraint.activateConstraints([
			leadingConstraint!,
			layoutView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor),
			layoutView.topAnchor.constraintEqualToAnchor(contentView.topAnchor),
			layoutView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor)
		])
		
		layoutView.layoutMarginsRelativeArrangement = true
		layoutView.layoutMargins = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
		
		layoutView.addArrangedSubviews(disclosureIndicator, label)
		disclosureIndicator.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
		
		disclosureIndicator.addTarget(self, action: "onDisclosurePress", forControlEvents: .TouchUpInside)
	}
	
	dynamic func onDisclosurePress() {
		delegate?.nodeCellDidTapDisclosureIndicator(self)
	}
	
	private func render() {
		guard let node = node else {
			label.attributedText = nil
			indentationLevel = 0
			return
		}
		
		indentationLevel = node.depth
		label.attributedText = theme.attributedStringForTokenList(node.tokenList)
		
		disclosureIndicator.expanded = expanded
		disclosureIndicator.alpha = node.isEmpty ? 0 : 1
//		disclosureIndicator.hidden = node.isEmpty
	}
	
}
