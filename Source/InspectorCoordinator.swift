//
//  InspectorCoordinator.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-03.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit
import Alamofire
import Fuzi

class InspectorCoordinator: Coordinator {
	
	// MARK: - Controllers
	
	private lazy var domInspectorController: DOMInspectorController = {
		let domInspectorController = DOMInspectorController()
		domInspectorController.delegate = self
		return domInspectorController
	}()
	
	private lazy var webViewController: WebViewController = {
		let webViewController = WebViewController()
		webViewController.delegate = self
		return webViewController
	}()
	
	lazy var rootViewController: UIViewController = {
		let splitController = ResizableSplitController(orientation: .Vertical)
		
		let domAttributesSplitController = UISplitViewController()
		domAttributesSplitController.delegate = self
		domAttributesSplitController.viewControllers = [
			UINavigationController(rootViewController: self.domInspectorController),
			NodeInspectorController()
		]
		
		splitController.controllers = [self.webViewController, domAttributesSplitController]
		return splitController
	}()
	
	var domAttributeSplitController: UISplitViewController {
		return (rootViewController as! ResizableSplitController).controllers.last as! UISplitViewController
	}
}

extension InspectorCoordinator: UISplitViewControllerDelegate {
	dynamic func splitViewController(
		splitViewController: UISplitViewController,
		collapseSecondaryViewController secondaryViewController: UIViewController,
		ontoPrimaryViewController primaryViewController: UIViewController
	) -> Bool {
		return (secondaryViewController as? NodeInspectorController)?.node == nil
	}
}

extension InspectorCoordinator: DOMInspectorControllerDelegate {
	func domInspectorController(controller: DOMInspectorController, didSelectNode node: XMLElement) {
		domAttributeSplitController.showDetailViewController(NodeInspectorController(node: node), sender: self)
		webViewController.highlightNodeWithSelector(node.uniqueSelector)
	}
}

extension InspectorCoordinator: WebViewControllerDelegate {
	func webViewController(webViewController: WebViewController, didLoadHTML html: String) {
		domInspectorController.document = try? HTMLDocument(string: html)
	}
}
