//
//  UIEdgeInsets+ExtensionsTests.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-07.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import XCTest
@testable import Source

class UIEdgeInsets_ExtensionsTests: XCTestCase {
    
	func testZeroReturnsAnEmptyInset() {
		XCTAssertEqual(UIEdgeInsets.zero, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
	}
    
}
