//
//  NodeCellSnapshotTests.swift
//  Inspector
//
//  Created by Chris Sauve on 2016-01-07.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import FBSnapshotTestCase
import Fuzi
@testable import Source

class NodeCellSnapshotTests: FBSnapshotTestCase {
	
	private let document = try! HTMLDocument(string: "<html class=\"foo bar baz\"></html>")
	
	override func setUp() {
		super.setUp()
		recordMode = false
	}
    
	func testRendersADOMNode() {
		let cell = NodeCell(frame: .zero)
		cell.node = document.root
		cell.sizeToFit()
		FBSnapshotVerifyView(cell)
	}
    
}
