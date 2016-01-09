//
//  NodeInspectorController.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-06.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit
import Fuzi

class NodeInspectorController: UITableViewController {
	
	typealias Attribute = (name: String, value: String)
	
	// MARK: - Properties
	
	var node: XMLElement? = nil {
		didSet {
			attributes = attributesForNode(node)
			tableView.reloadData()
		}
	}
	
	var attributes: [Attribute] = []
	
	func attributesForNode(node: XMLElement?) -> [Attribute] {
		return node == nil ? [] : Array(node!.attributes).sort { $0.0 < $1.0 }
	}
	
	// MARK: - Initializers
	
	init(node: XMLElement? = nil) {
		super.init(style: .Plain)
		self.node = node
		self.attributes = attributesForNode(node)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.registerClass(NodeAttributeCell.self, forCellReuseIdentifier: "NodeAttributeCell")
	}
	
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return node == nil ? 0 : 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return attributes.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("NodeAttributeCell", forIndexPath: indexPath) as! NodeAttributeCell
		
		let attribute = attributes[indexPath.row]
		cell.textLabel?.text = attribute.name
		cell.detailTextLabel?.text = attribute.value
		
		return cell
	}


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
