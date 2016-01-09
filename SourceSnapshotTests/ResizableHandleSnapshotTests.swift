//
//  ResizableHandleSnapshotTests.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-07.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import FBSnapshotTestCase
@testable import Source

class ResizableHandleCellSnapshotTests: FBSnapshotTestCase {
	
	var container: UIView!
	
	override func setUp() {
		super.setUp()
		container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
		recordMode = false
	}
	
	func testRendersHorizontally() {
		let handle = ResizableHandle(orientation: .Horizontal)
		container.addSubviewsForAutolayout(handle)
		NSLayoutConstraint.activateConstraints([
			handle.centerYAnchor.constraintEqualToAnchor(container.centerYAnchor),
			handle.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor),
			handle.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor)
		])
		
		FBSnapshotVerifyView(container)
		XCTAssertEqual(handle.frame.height, ResizableHandle.Constants.size)
	}
	
	func testRendersVertically() {
		let handle = ResizableHandle(orientation: .Vertical)
		container.addSubviewsForAutolayout(handle)
		NSLayoutConstraint.activateConstraints([
			handle.centerXAnchor.constraintEqualToAnchor(container.centerXAnchor),
			handle.topAnchor.constraintEqualToAnchor(container.topAnchor),
			handle.bottomAnchor.constraintEqualToAnchor(container.bottomAnchor)
		])
		
		FBSnapshotVerifyView(container)
		XCTAssertEqual(handle.frame.width, ResizableHandle.Constants.size)
	}
	
}
