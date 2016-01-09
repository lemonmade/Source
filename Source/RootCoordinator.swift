//
//  File.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-03.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {
	lazy var inspectorCoordinator = InspectorCoordinator()
	lazy var navigationController = UINavigationController()
	
	var rootViewController: UIViewController {
		return inspectorCoordinator.rootViewController
	}
}
