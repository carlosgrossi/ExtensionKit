//
//  UILabel.swift
//  ExtensionKit
//
//  Created by Carlos Grossi on 22/06/17.
//  Copyright © 2017 Carlos Grossi. All rights reserved.
//

import Foundation

public extension UILabel {
	
	convenience init(text: String, numberOfLines: Int = 0, textAlignment: NSTextAlignment = .center, font: UIFont?) {
		self.init(frame: CGRect.zero)
		self.text = text
		self.numberOfLines = numberOfLines
		self.textAlignment = textAlignment
		self.font = font ?? UIFont.systemFont(ofSize: 20)
		self.sizeToFit()
	}
	
}
