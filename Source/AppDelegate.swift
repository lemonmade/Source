//
//  AppDelegate.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-02.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	lazy var rootCoordinator = RootCoordinator()
	
	func application(
		application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?
		) -> Bool {
			let window = UIWindow()
			window.rootViewController = rootCoordinator.rootViewController
			window.makeKeyAndVisible()
			self.window = window
			
			setupAppearance()
			
			return true
	}
	
	private func setupAppearance() {
		
	}
	
}
