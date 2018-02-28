//
//  UITableView.swift
//  ExtensionKit
//
//  Created by Carlos Grossi on 22/06/17.
//  Copyright © 2017 Carlos Grossi. All rights reserved.
//

import Foundation

public extension UITableView {
	
	public func setBackgroundMessage(with text: String, font: UIFont? = nil) {
		backgroundView = UILabel(text: text, font: font)
	}
	
}
