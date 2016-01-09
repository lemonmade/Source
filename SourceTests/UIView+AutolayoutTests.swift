//
//  UIView+AutolayoutTests.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-07.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import XCTest
@testable import Source

class UIView_AutolayoutTests: XCTestCase {
	
	var superview: UIView!
	let layoutMargins = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
	
	override func setUp() {
		super.setUp()
		superview = UIView()
	}
	
	func testAddSubviewsForAutolayout() {
		let viewOne = UIView()
		let viewTwo = UIView()
		
		superview.addSubviewsForAutolayout(viewOne, viewTwo)
		
		[viewOne, viewTwo].forEach { view in
			XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
			XCTAssertTrue(view.superview == superview)
		}
	}
	
	func testConstrainToFillView() {
		let subview = UIView()
		superview.addSubviewsForAutolayout(subview)
		subview.constrainToFillView(superview)
		
		sampleRandomLayoutFramesForView(superview) {
			XCTAssertEqual(self.superview.frame, subview.frame)
		}
	}
	
	func testConstrainToFillViewRespectingLayoutMargins() {
		let subview = UIView()
		superview.layoutMargins = layoutMargins
		superview.addSubviewsForAutolayout(subview)
		subview.constrainToFillView(superview, respectingLayoutMargins: true)
		
		sampleRandomLayoutFramesForView(superview) {
			XCTAssertEqual(subview.frame, self.superview.frame.insetBy(self.layoutMargins))
		}
	}
	
	func testConstrainToFillViewHorizontally() {
		let subview = UIView()
		superview.addSubviewsForAutolayout(subview)
		subview.constrainToFillViewHorizontally(superview)
		
		sampleRandomLayoutFramesForView(superview) {
			XCTAssertEqual(subview.frame.origin.x, 0)
			XCTAssertEqual(subview.frame.width, self.superview.frame.width)
		}
	}
	
	func testConstrainToFillViewHorizontallyRespectingLayoutMargins() {
		let subview = UIView()
		superview.layoutMargins = layoutMargins
		superview.addSubviewsForAutolayout(subview)
		subview.constrainToFillViewHorizontally(superview, respectingLayoutMargins: true)
		
		sampleRandomLayoutFramesForView(superview) {
			let insetFrame = self.superview.frame.insetBy(self.layoutMargins)
			XCTAssertEqual(subview.frame.origin.x, insetFrame.origin.x)
			XCTAssertEqual(subview.frame.width, insetFrame.width)
		}
	}
	
	func testConstrainToFillViewVertically() {
		let subview = UIView()
		superview.addSubviewsForAutolayout(subview)
		subview.constrainToFillViewVertically(superview)
		
		sampleRandomLayoutFramesForView(superview) {
			XCTAssertEqual(subview.frame.origin.y, 0)
			XCTAssertEqual(subview.frame.height, self.superview.frame.height)
		}
	}
	
	func testConstrainToFillViewVerticallyRespectingLayoutMargins() {
		let subview = UIView()
		superview.layoutMargins = layoutMargins
		superview.addSubviewsForAutolayout(subview)
		subview.constrainToFillViewVertically(superview, respectingLayoutMargins: true)
		
		sampleRandomLayoutFramesForView(superview) {
			let insetFrame = self.superview.frame.insetBy(self.layoutMargins)
			XCTAssertEqual(subview.frame.origin.y, insetFrame.origin.y)
			XCTAssertEqual(subview.frame.height, insetFrame.height)
		}
	}
	
	func testConstrainToBeCenteredInView() {
		let subview = UIView()
		let targetSize: CGFloat = 2
		
		superview.addSubviewsForAutolayout(subview)
		subview.constrainToBeCenteredInView(superview)
		NSLayoutConstraint.activateConstraints([
			subview.heightAnchor.constraintEqualToConstant(targetSize),
			subview.widthAnchor.constraintEqualToConstant(targetSize)
			])
		
		sampleRandomLayoutFramesForView(superview) {
			let subviewFrame = subview.frame
			let superviewFrame = self.superview.frame
			
			XCTAssertEqual(subviewFrame.width, targetSize)
			XCTAssertEqual(subviewFrame.width, targetSize)
			XCTAssertEqual(subviewFrame.center.x, superviewFrame.width / 2.0)
			XCTAssertEqual(subviewFrame.center.y, superviewFrame.height / 2.0)
		}
	}
	
	private func sampleRandomLayoutFramesForView(view: UIView, test: () -> Void) {
		5.times {
			// Needs to multiply by scale to prevent subpixel rounding issues
			let resolution = UIScreen().scale
			let targetFrame = CGRect(
				x: 0,
				y: 0,
				width: (CGFloat(arc4random_uniform(2000)) + 20) * 2.0 / resolution,
				height: (CGFloat(arc4random_uniform(2000)) + 20) * 2.0 / resolution
			)
			
			view.frame = targetFrame
			view.layoutIfNeeded()
			
			test()
		}
	}
	
}
