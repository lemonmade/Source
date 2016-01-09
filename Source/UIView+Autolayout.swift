//
//  UIView+Autolayout.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-04.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

import UIKit

extension UIView {
	func addSubviewsForAutolayout(views: UIView...) {
		views.forEach { view in
			view.translatesAutoresizingMaskIntoConstraints = false
			addSubview(view)
		}
	}
	
	func constraintsToFillView(otherView: UIView, respectingLayoutMargins: Bool = false) -> [NSLayoutConstraint] {
		return constraintsToFillViewHorizontally(otherView, respectingLayoutMargins: respectingLayoutMargins) + constraintsToFillViewVertically(otherView, respectingLayoutMargins: respectingLayoutMargins)
	}
	
	func constraintsToFillViewVertically(otherView: UIView, respectingLayoutMargins: Bool = false) -> [NSLayoutConstraint] {
		if respectingLayoutMargins {
			let layoutMarginsGuide = otherView.layoutMarginsGuide
			
			return [
				topAnchor.constraintEqualToAnchor(layoutMarginsGuide.topAnchor),
				bottomAnchor.constraintEqualToAnchor(layoutMarginsGuide.bottomAnchor)
			]
		}
		
		return [
			topAnchor.constraintEqualToAnchor(otherView.topAnchor),
			bottomAnchor.constraintEqualToAnchor(otherView.bottomAnchor)
		]
	}
	
	func constraintsToFillViewHorizontally(otherView: UIView, respectingLayoutMargins: Bool = false) -> [NSLayoutConstraint] {
		if respectingLayoutMargins {
			let layoutMarginsGuide = otherView.layoutMarginsGuide
			
			return [
				leadingAnchor.constraintEqualToAnchor(layoutMarginsGuide.leadingAnchor),
				trailingAnchor.constraintEqualToAnchor(layoutMarginsGuide.trailingAnchor)
			]
		}
		
		return [
			leadingAnchor.constraintEqualToAnchor(otherView.leadingAnchor),
			trailingAnchor.constraintEqualToAnchor(otherView.trailingAnchor)
		]
	}
	
	func constraintsToBeCenteredInView(otherView: UIView) -> [NSLayoutConstraint] {
		return [
			centerXAnchor.constraintEqualToAnchor(otherView.centerXAnchor),
			centerYAnchor.constraintEqualToAnchor(otherView.centerYAnchor)
		]
	}
	
	func constrainToFillView(otherView: UIView, respectingLayoutMargins: Bool = false) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activateConstraints(constraintsToFillView(otherView, respectingLayoutMargins: respectingLayoutMargins))
	}
	
	func constrainToFillViewVertically(otherView: UIView, respectingLayoutMargins: Bool = false) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activateConstraints(constraintsToFillViewVertically(otherView, respectingLayoutMargins: respectingLayoutMargins))
	}
	
	func constrainToFillViewHorizontally(otherView: UIView, respectingLayoutMargins: Bool = false) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activateConstraints(constraintsToFillViewHorizontally(otherView, respectingLayoutMargins: respectingLayoutMargins))
	}
	
	func constrainToBeCenteredInView(otherView: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activateConstraints(constraintsToBeCenteredInView(otherView))
	}
}
