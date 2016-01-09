//
//  ResizableSplitController.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-04.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

class ResizableSplitController: UIViewController {
	
	// MARK: - Properties
	
	var orientation: Orientation = .Vertical
	var isVertical: Bool { return orientation == .Vertical }
	var isHorizontal: Bool { return orientation == .Horizontal }

	var controllers: [UIViewController] = [] {
		didSet {
			oldValue.forEach(removeChildViewControllerWithMovement)
			controllers.forEach(addChildViewControllerWithMovement)
			split = 0.5
		}
	}
	
	var split: CGFloat = 0.5 {
		didSet { updateLayout() }
	}
	
	private lazy var handle: ResizableHandle = {
		let handle = ResizableHandle()
		handle.addTarget(self, action: "handleMove:withEvent:", forControlEvents: .TouchDragInside)
		return handle
	}()
	
	dynamic func handleMove(handle: ResizableHandle, withEvent event: UIEvent) {
		guard let touch = event.allTouches()?.first else { return }
		split = touch.locationInView(view).y / view.frame.height
	}
	
	// MARK: - Initializers
	
	init(orientation: Orientation) {
		self.orientation = orientation
		super.init(nibName: nil, bundle: nil)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: - Lifecycle
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		updateLayout()
	}
	
	// MARK: - Setup
	
	func setup() {
		view.backgroundColor = .blueColor()
		view.addSubviewsForAutolayout(handle)
	}
	
	// MARK: - Layout
	
	func updateLayout() {
		guard !controllers.isEmpty else { return }
		
		let frame = view.frame
		let firstView = controllers.first!.view
		let secondView = controllers.last!.view
		let handleSize = ResizableHandle.Constants.size
		
		firstView.frame = CGRect(
			origin: .zero,
			size: CGSize(width: frame.width, height: frame.height * split - (handleSize / 2.0))
		)
		
		handle.frame = CGRect(
			center: CGPoint(x: frame.center.x, y: split * frame.height),
			size: CGSize(width: frame.width, height: handleSize)
		)
		
		secondView.frame = CGRect(
			origin: CGPoint(x: 0, y: handle.frame.center.y + (handleSize / 2.0)),
			size: CGSize(width: frame.width, height: frame.height * (1.0 - split) - (handleSize / 2.0))
		)
	}

}
