//
//  UIViewController+Extensions.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-04.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

extension UIViewController {
	func addChildViewControllerWithMovement(controller: UIViewController) {
		controller.willMoveToParentViewController(self)
		addChildViewController(controller)
		view.addSubviewsForAutolayout(controller.view)
		controller.didMoveToParentViewController(self)
	}
	
	func removeChildViewControllerWithMovement(controller: UIViewController) {
		controller.willMoveToParentViewController(nil)
		controller.view.removeFromSuperview()
		controller.removeFromParentViewController()
		controller.didMoveToParentViewController(nil)
	}
}
