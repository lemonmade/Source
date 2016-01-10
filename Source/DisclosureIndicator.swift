//
//  DisclosureIndicator.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-09.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

class DisclosureIndicator: UIButton {
	
	struct Constants {
		static let size: CGFloat = 16
	}
	
	var expanded: Bool = false {
		didSet {
			guard oldValue != expanded else { return }
			setNeedsDisplay()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func intrinsicContentSize() -> CGSize {
		return CGSize(width: Constants.size, height: Constants.size)
	}
	
	private func setup() {
		backgroundColor = Colors.clear
	}
	
	override func drawRect(rect: CGRect) {
		let angle = CGFloat(M_PI) / CGFloat(3)
		let width = frame.width
		let height = sin(angle) * width
		let startY = (frame.height - height) / 2.0
		
		let startPoint = CGPoint(x: 0, y: startY)
		let endPoint = CGPoint(x: width, y: startY)
		let midPoint = CGPoint(
			x: startPoint.x + cos(angle) * width,
			y: startPoint.y + sin(angle) * width
		)
		
		let path = UIBezierPath()
		path.moveToPoint(startPoint)
		path.addLineToPoint(midPoint)
		path.addLineToPoint(endPoint)
		path.closePath()
		
		if !expanded {
			let center = bounds.center
			path.applyTransform(CGAffineTransformMakeTranslation(-center.x, -center.y))
			path.applyTransform(CGAffineTransformMakeRotation(CGFloat(M_PI) / -2.0))
			path.applyTransform(CGAffineTransformMakeTranslation(center.x, center.y))
		}
		
		Colors.gray.set()
		path.fill()
	}
	
}
