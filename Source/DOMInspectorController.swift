//
//  DOMInspectorController.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-03.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit
import Fuzi

protocol DOMInspectorControllerDelegate: class {
	func domInspectorController(controller: DOMInspectorController, didSelectNode node: XMLElement)
}

class DOMInspectorController: UITableViewController {
	
	// MARK: - Properties
	
	weak var delegate: DOMInspectorControllerDelegate?
	
	private lazy var prototypeCell: NodeCell = {
		return self.tableView.dequeueReusableCellWithIdentifier("node") as! NodeCell
	}()
	
	var document: HTMLDocument? {
		didSet {
			if let root = document?.root {
				nodes = [root] + root.children
			} else {
				nodes = []
			}
			
			tableView.reloadData()
			tableView.scrollToNearestSelectedRowAtScrollPosition(.Top, animated: false)
		}
	}
	
	private var nodes: [XMLElement] = []
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.tableFooterView = UIView()
		tableView.backgroundView = UIView(backgroundColor: Colors.grayLight)
		
		tableView.separatorStyle = .None
		
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44
		tableView.registerClass(NodeCell.self, forCellReuseIdentifier: "node")
	}
	
	// MARK: - TableView
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let tableCell = tableView.dequeueReusableCellWithIdentifier("node") as! NodeCell
		tableCell.node = nodes[indexPath.row]
		tableCell.delegate = self
		tableCell.expanded = nodeIsExpandedAtIndexPath(indexPath)
		return tableCell
	}
	
	private func nodeIsExpandedAtIndexPath(indexPath: NSIndexPath) -> Bool {
		let node = nodes[indexPath.row]
		let nextIndex = indexPath.row + 1
		let nextNode: XMLElement? = nextIndex == nodes.count ? nil : nodes[nextIndex]
		
		return nextNode == node.children.first
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return nodes.count
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate?.domInspectorController(self, didSelectNode: nodes[indexPath.row])
		
//		let node = nodes[indexPath.row]
//		let nextIndex = indexPath.row + 1
//		let nextNode: XMLElement? = nextIndex == nodes.count ? nil : nodes[nextIndex]
//
//		if nextNode != node.children.first {
//			insertChildrenOfNodeAtIndexPath(indexPath)
//		} else {
//			removeChildrenOfNodeAtIndexPath(indexPath)
//		}
	}
	
	private func insertChildrenOfNodeAtIndexPath(indexPath: NSIndexPath) {
		let node = nodes[indexPath.row]
		let nodeChildren = node.children
		let nextIndex = indexPath.row + 1
		let indexPaths = NSIndexPath.indexPathsForRowsInRange(nextIndex..<(nextIndex + nodeChildren.count))
		
		nodes.insertContentsOf(nodeChildren, at: nextIndex)
		tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
	}
	
	private func removeChildrenOfNodeAtIndexPath(indexPath: NSIndexPath) {
		let node = nodes[indexPath.row]
		guard let lastChild = node.children.last, lastChildIndex = nodes.indexOf(lastChild) else { return }
		let removeRange = (indexPath.row + 1)...lastChildIndex
		
		nodes.removeRange(removeRange)
		tableView.deleteRowsAtIndexPaths(NSIndexPath.indexPathsForRowsInRange(removeRange), withRowAnimation: .Fade)
	}
	
	override func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}
	
	override func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
		return action == "copy:"
	}
	
	override func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
		guard action == "copy:" else { return }
		guard let node = (tableView.cellForRowAtIndexPath(indexPath) as? NodeCell)?.node?.rawXML else { return }
		UIPasteboard.generalPasteboard().string = node
	}
	
}

extension DOMInspectorController: NodeCellDelegate {
	func nodeCellDidTapDisclosureIndicator(nodeCell: NodeCell) {
		guard let indexPath = tableView.indexPathForCell(nodeCell) else { return }
		nodeCell.expanded = !nodeCell.expanded
		
		if nodeIsExpandedAtIndexPath(indexPath) {
			removeChildrenOfNodeAtIndexPath(indexPath)
		} else {
			insertChildrenOfNodeAtIndexPath(indexPath)
		}
	}
}
