//
//  UIView+StyleTests.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-07.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import XCTest
@testable import Source

class UIView_StyleTests: XCTestCase {
    
	func testInitWithBackgroundColorCreatesAColoredView() {
		let color = UIColor.redColor()
		let view = UIView(backgroundColor: color)
		
		XCTAssertEqual(view.backgroundColor, color)
		XCTAssertEqual(view.frame, CGRect.zero)
	}
    
}
