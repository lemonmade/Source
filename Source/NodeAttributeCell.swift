//
//  NodeAttributeCell.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-06.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

class NodeAttributeCell: UITableViewCell {
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
