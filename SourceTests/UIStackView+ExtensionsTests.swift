//
//  UIStackView+ExtensionsTests.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-09.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import XCTest
@testable import Source

class UIStackView_ExtensionsTests: XCTestCase {
	
	func testConvenienceInitializer() {
		let axis: UILayoutConstraintAxis = .Vertical
		let distribution: UIStackViewDistribution = .EqualCentering
		let alignment: UIStackViewAlignment = .LastBaseline
		let spacing: CGFloat = 20
		
		let stackView = UIStackView(axis: axis, distribution: distribution, alignment: alignment, spacing: spacing)
		
		XCTAssertEqual(stackView.axis, axis)
		XCTAssertEqual(stackView.distribution, distribution)
		XCTAssertEqual(stackView.alignment, alignment)
		XCTAssertEqual(stackView.spacing, spacing)
	}
	
	func testConvenienceInitializerProvidesSensibleDefaults() {
		let stackView = UIStackView(axis: .Vertical)
		
		XCTAssertEqual(stackView.distribution, UIStackViewDistribution.Fill)
		XCTAssertEqual(stackView.alignment, UIStackViewAlignment.Leading)
		XCTAssertEqual(stackView.spacing, 0)
	}
	
	func testAddArrangedSubviewsAddsEachSubview() {
		let viewOne = UIView()
		let viewTwo = UIView()
		let stackView = UIStackView()
		
		stackView.addArrangedSubviews(viewOne, viewTwo)
		[viewOne, viewTwo].forEach { XCTAssertTrue(stackView.arrangedSubviews.contains($0)) }
	}
	
}
