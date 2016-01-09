//
//  UIView+Style.swift
//  inspector
//
//  Created by Chris Sauve on 2016-01-06.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import UIKit

extension UIView {
	convenience init(backgroundColor: UIColor) {
		self.init(frame: .zero)
		self.backgroundColor = backgroundColor
	}
}
