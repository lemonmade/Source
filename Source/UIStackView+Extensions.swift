//
//  UIStackView+Extensions.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-09.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

extension UIStackView {
	convenience init(
		axis: UILayoutConstraintAxis,
		distribution: UIStackViewDistribution = .Fill,
		alignment: UIStackViewAlignment = .Leading,
		spacing: CGFloat = 0
		) {
			self.init()
			self.distribution = distribution
			self.alignment = alignment
			self.axis = axis
			self.spacing = spacing
	}
	
	func addArrangedSubviews(views: UIView...) {
		views.forEach(addArrangedSubview)
	}
}
