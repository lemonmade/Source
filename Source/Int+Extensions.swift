//
//  Int+Extensions.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-07.
//  Copyright © 2016 lemonmade. All rights reserved.
//

extension Int {
	func times(block: (Int) -> Void) {
		(0..<self).forEach(block)
	}
	
	func times(block: () -> Void) {
		for _ in 0..<self { block() }
	}
}
