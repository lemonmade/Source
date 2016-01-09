//
//  UIColor+ExtensionsTests.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-07.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import XCTest
@testable import Source

class UIColor_ExtensionsTests: XCTestCase {
	
	private let red = 55
	private let green = 125
	private let blue = 215
	private lazy var expected: UIColor = {
		return UIColor(
			red: CGFloat(self.red) / 255.0,
			green: CGFloat(self.green) / 255.0,
			blue: CGFloat(self.blue) / 255.0,
			alpha: 1
		)
	}()
    
	func testInitWithRedGreenBlueCreatesTheColor() {
		let color = UIColor(red: red, green: green, blue: blue)
		XCTAssertEqual(color, expected)
	}
	
	func testInitWithRGBCreatesTheColor() {
		let color = UIColor(r: red, g: green, b: blue)
		XCTAssertEqual(color, expected)
	}
	
	func testInitWithHexCreatesTheColor() {
		let expected = UIColor(red: 113, green: 130, blue: 255)
		let color = UIColor(hex: 0x7182FF)
		XCTAssertEqual(color, expected)
	}
	
	func testStaticRGBCreatesTheColor() {
		let color = UIColor.rgb(red, green, blue)
		XCTAssertEqual(color, expected)
	}
    
}
