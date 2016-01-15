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
	
	private func verifyIndexPaths(indexPaths: [NSIndexPath], fromRow: Int, toRow: Int, fromSection: Int, toSection: Int) {
		let sectionCount = (toSection - fromSection + 1)
		let rowCount = (toRow - fromRow + 1)
		
		XCTAssertEqual(indexPaths.count, sectionCount * rowCount)
		
		for section in fromSection...toSection {
			for row in fromRow...toRow {
				XCTAssert(indexPaths.contains(NSIndexPath(forRow: row, inSection: section)))
			}
		}
	}
    
	func testIndexPathsForRowsInRangeReturnsAllIndexPathsInTheFirstSection() {
		verifyIndexPaths(NSIndexPath.indexPathsForRowsInRange(3...5), fromRow: 3, toRow: 5, fromSection: 0, toSection: 0)
	}
	
	func testIndexPathsForRowsInRangeUsesPassedSection() {
		verifyIndexPaths(NSIndexPath.indexPathsForRowsInRange(1..<4, inSection: 4), fromRow: 1, toRow: 3, fromSection: 4, toSection: 4)
	}
	
	func testIndexPathsForRowsInRangeUsesPassedSectionRange() {
		verifyIndexPaths(NSIndexPath.indexPathsForRowsInRange(1...2, forSectionsInRange: 2..<5), fromRow: 1, toRow: 2, fromSection: 2, toSection: 4)
	}
    
}
