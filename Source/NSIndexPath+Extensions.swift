//
//  NSIndexPath+Extensions.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-04.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import Foundation

extension NSIndexPath {
	static func indexPathsForRowsInRange(
		rowRange: Range<Int>,
		forSectionsInRange sectionRange: Range<Int>
		) -> [NSIndexPath] {
			var indexPaths: [NSIndexPath] = []
			for section in sectionRange {
				indexPaths.appendContentsOf(rowRange.map { NSIndexPath(forRow: $0, inSection: section) })
			}
			return indexPaths
	}
	
	static func indexPathsForRowsInRange(
		rowRange: Range<Int>,
		inSection section: Int = 0
		) -> [NSIndexPath] {
			return indexPathsForRowsInRange(rowRange, forSectionsInRange: section...section)
	}
}
