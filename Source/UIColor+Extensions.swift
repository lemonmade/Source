//
//  UIColor+Extensions.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-06.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(r: Int, g: Int, b: Int) {
		self.init(red: r, green: g, blue: b)
	}
	
	convenience init(hex: Int) {
		self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff)
	}
	
	static func rgb(red: Int, _ green: Int, _ blue: Int) -> UIColor {
		return UIColor(r: red, g: green, b: blue)
	}
}
