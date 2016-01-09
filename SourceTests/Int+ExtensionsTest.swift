//
//  Int+AdditionsTest.swift
//  Onboarding
//
//  Created by Chris Sauve on 2015-12-13.
//  Copyright © 2015 lemonmade. All rights reserved.
//

import XCTest
@testable import Source

class Int_AdditionsTest: XCTestCase {

	func testTimesRunsBlock() {
		var count = 0
		let target = 11
		
		target.times { count += 1 }
		
		XCTAssertEqual(count, target)
	}
	
	func testTimesRunsBlockWithIndex() {
		var currentIndex = 0
		
		11.times { (index: Int) in
			XCTAssertEqual(index, currentIndex)
			currentIndex += 1
		}
	}

}
