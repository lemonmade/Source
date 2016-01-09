//
//  CGRect+Extensions.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-04.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

extension CGRect {
	init(center: CGPoint, size: CGSize) {
		let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
		self.init(origin: origin, size: size)
	}
	
	func insetBy(edgeInsets: UIEdgeInsets) -> CGRect {
		return CGRect(
			x: origin.x + edgeInsets.left,
			y: origin.y + edgeInsets.top,
			width: width - (edgeInsets.left + edgeInsets.right),
			height: height - (edgeInsets.top + edgeInsets.bottom)
		)
	}
	
	var center: CGPoint {
		get {
			return CGPoint(x: origin.x + width / 2.0, y: origin.y + height / 2.0)
		}
		
		mutating set {
			origin = CGPoint(x: newValue.x - width / 2.0, y: newValue.y - height / 2.0)
		}
	}
}
