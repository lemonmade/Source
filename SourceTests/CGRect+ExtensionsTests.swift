//
//  CGRect+ExtensionsTests.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-07.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import XCTest
@testable import Source

class CGRect_ExtensionsTests: XCTestCase {
	
	var random: CGFloat {
		return CGFloat(arc4random_uniform(300))
	}
	
	func testInitWithCenterAndSizeCreatesTheCorrectRect() {
		let size = CGSize(width: random, height: random)
		let center = CGPoint(x: random, y: random)
		
		let rect = CGRect(center: center, size: size)
		let expected = CGRect(
			origin: CGPoint(x: center.x - (size.width / 2.0), y: center.y - (size.height / 2.0)),
			size: size
		)
		
		XCTAssertEqual(rect, expected)
	}
	
	func testCenterReturnsTheCenterOfTheRect() {
		let rect = CGRect(x: random, y: random, width: random, height: random)
		let expected = CGPoint(x: rect.origin.x + (rect.width / 2.0), y: rect.origin.y + (rect.height / 2.0))
		
		XCTAssertEqual(rect.center, expected)
	}
	
	func testCenterSetterUpdatesCenter() {
		var rect = CGRect(x: random, y: random, width: random, height: random)
		let newCenter = CGPoint(x: random, y: random)
		let expectedRect = CGRect(center: newCenter, size: rect.size)
		
		rect.center = newCenter
		XCTAssertEqual(rect, expectedRect)
	}
	
	func testInsetByInsetsRect() {
		let insetRange: CGFloat = 10
		
		let rect = CGRect(
			x: random + insetRange,
			y: random + insetRange,
			width: random + insetRange,
			height: random + insetRange
		)
		
		let inset = UIEdgeInsets(
			top: CGFloat(arc4random_uniform(UInt32(insetRange))),
			left: CGFloat(arc4random_uniform(UInt32(insetRange))),
			bottom: CGFloat(arc4random_uniform(UInt32(insetRange))),
			right: CGFloat(arc4random_uniform(UInt32(insetRange)))
		)
		
		let expectedRect = CGRect(
			x: rect.origin.x + inset.left,
			y: rect.origin.y + inset.top,
			width: rect.width - (inset.left + inset.right),
			height: rect.height - (inset.top + inset.bottom)
		)
		
		XCTAssertEqual(rect.insetBy(inset), expectedRect)
	}
	
}
