//
//  WebViewController.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-04.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: class {
	func webViewController(webViewController: WebViewController, didLoadHTML html: String)
}

class WebViewController: UIViewController {
	
	// MARK: - Properties
	
	weak var delegate: WebViewControllerDelegate?
	
	var webView: WKWebView {
		return view as! WKWebView
	}
	
	// MARK: - Lifecycle

	override func loadView() {
		let webView = WKWebView()
		webView.navigationDelegate = self
		self.view = webView
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
//		let request = NSURLRequest(URL: NSURL(string: "http://bigfootjs.com/")!)
//		webView.loadRequest(request)
		webView.loadFileURL(
			NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ExampleDocument", ofType: "html")!),
			allowingReadAccessToURL: NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)
		)
	}
	
	func highlightNodeWithSelector(selector: String) {
		let javascript = [
			"(function() {",
			"  var node = document.querySelector('\(selector)');",
			"  node.style.backgroundColor = 'blue';",
			"})()"
		].joinWithSeparator("\n")
		
		webView.evaluateJavaScript(javascript) { result, error in
			print(result, error)
		}
	}

}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
	
	func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
		webView.evaluateJavaScript("document.documentElement.outerHTML") { [unowned self] result, error in
			guard error == nil, let html = result as? String else { return }
			self.delegate?.webViewController(self, didLoadHTML: html)
		}
	}
	
}
