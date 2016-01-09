//
//  UIViewController+ExtensionsTests.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-07.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import XCTest
@testable import Source

class UIViewController_ExtensionsTests: XCTestCase {
	
	private class ContainerView: UIView {
		var addedChild: UIView? = nil
		
		override func addSubview(view: UIView) {
			super.addSubview(view)
			addedChild = view
		}
	}
	
	private class ContainerController: UIViewController {
		var addedChild: UIViewController? = nil
		
		override func addChildViewController(childController: UIViewController) {
			super.addChildViewController(childController)
			addedChild = childController
		}
		
		override func loadView() {
			self.view = ContainerView()
		}
	}
	
	private class ContainedView: UIView {
		var removedFromParent = false
		
		override func removeFromSuperview() {
			super.removeFromSuperview()
			removedFromParent = true
		}
	}
	
	private class ContainedController: UIViewController {
		var willMoveToParent: UIViewController? = nil
		var didMoveToParent: UIViewController? = nil
		var removedFromParent = false
		
		override func loadView() {
			self.view = ContainedView()
		}
		
		override func willMoveToParentViewController(parent: UIViewController?) {
			super.willMoveToParentViewController(parent)
			willMoveToParent = parent
		}
		
		override func didMoveToParentViewController(parent: UIViewController?) {
			super.didMoveToParentViewController(parent)
			didMoveToParent = parent
		}
		
		override func removeFromParentViewController() {
			super.removeFromParentViewController()
			removedFromParent = true
		}
	}
	
	private var containerController: ContainerController!
	private var containedController: ContainedController!
	
	override func setUp() {
		super.setUp()
		
		containerController = ContainerController()
		containedController = ContainedController()
	}
    
	func testAddChildViewControllerCallsCorrectContainmentMethods() {
		containerController.addChildViewControllerWithMovement(containedController)

		XCTAssertEqual(containerController.addedChild, containedController)
		XCTAssertEqual(containedController.willMoveToParent, containerController)
		XCTAssertEqual(containedController.didMoveToParent, containerController)
		XCTAssertEqual((containerController.view as! ContainerView).addedChild, containedController.view)
	}
	
	func testRemoveChildViewControllerCallsCorrectContainmentMethods() {
		containerController.addChildViewControllerWithMovement(containedController)
		containerController.removeChildViewControllerWithMovement(containedController)
		
		XCTAssertTrue(containedController.removedFromParent)
		XCTAssertNil(containedController.willMoveToParent)
		XCTAssertNil(containedController.didMoveToParent)
		XCTAssertTrue((containedController.view as! ContainedView).removedFromParent)
	}
    
}
