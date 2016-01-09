//
//  NSIndexPath+ExtensionsTests.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-07.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import XCTest
@testable import Source

class NSIndexPath_ExtensionsTests: XCTestCase {
    
	func testIndexPathsForRowsInRangeReturnsAllIndexPathsInTheFirstSection() {
		let actual = NSIndexPath.indexPathsForRowsInRange(3...5)
		let expected = [
			NSIndexPath(forRow: 3, inSection: 0),
			NSIndexPath(forRow: 4, inSection: 0),
			NSIndexPath(forRow: 5, inSection: 0)
		]
		
		XCTAssertEqual(actual, expected)
	}
	
	func testIndexPathsForRowsInRangeUsesPassedSection() {
		let actual = NSIndexPath.indexPathsForRowsInRange(1..<4, inSection: 4)
		let expected = [
			NSIndexPath(forRow: 1, inSection: 4),
			NSIndexPath(forRow: 2, inSection: 4),
			NSIndexPath(forRow: 3, inSection: 4)
		]
		
		XCTAssertEqual(actual, expected)
	}
	
	func testIndexPathsForRowsInRangeUsesPassedSectionRange() {
		let actual = NSIndexPath.indexPathsForRowsInRange(1...2, forSectionsInRange: 2..<5)
		let expected = [
			NSIndexPath(forRow: 1, inSection: 2),
			NSIndexPath(forRow: 2, inSection: 2),
			NSIndexPath(forRow: 1, inSection: 3),
			NSIndexPath(forRow: 2, inSection: 3),
			NSIndexPath(forRow: 1, inSection: 4),
			NSIndexPath(forRow: 2, inSection: 4)
		]
		
		XCTAssertEqual(actual, expected)
	}
    
}
