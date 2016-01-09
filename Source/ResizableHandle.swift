//
//  ResizableHandle.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-04.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

typealias Orientation = UILayoutConstraintAxis

class ResizableHandle: UIControl {
	
	// MARK: - Constants
	
	struct Constants {
		static let size: CGFloat = 30
		static let grabberThickness: CGFloat = 8
		static let grabberLength: CGFloat = 50
	}
	
	// MARK: - Properties
	
	var orientation: Orientation = .Horizontal
	var isVertical: Bool { return orientation == .Vertical }
	var isHorizontal: Bool { return orientation == .Horizontal }
	
	// MARK: - Initializers
	
	init(orientation: Orientation) {
		super.init(frame: .zero)
		self.orientation = orientation
		setup()
		render()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
		render()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Layout
	
	override func intrinsicContentSize() -> CGSize {
		return CGSize(
			width: isVertical ? Constants.size : UIViewNoIntrinsicMetric,
			height: isHorizontal ? Constants.size : UIViewNoIntrinsicMetric
		)
	}
	
	// MARK: - Setup
	
	private func setup() {
		backgroundColor = Colors.grayLight
	}
	
	// MARK: - Render
	
	private func render() {
		
	}
	
	override func drawRect(rect: CGRect) {
		let rectToRound = CGRect(
			center: bounds.center,
			size: isVertical ? CGSize(width: Constants.grabberThickness, height: Constants.grabberLength) : CGSize(width: Constants.grabberLength, height: Constants.grabberThickness)
		)
		let path = UIBezierPath(roundedRect: rectToRound, cornerRadius: Constants.grabberThickness / 2.0)
		
		Colors.gray.set()
		path.fill()
	}
	
}
