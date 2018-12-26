//
//  NSLayoutConstraint.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

public extension NSLayoutConstraint {
	
	public struct Constats {
		var constants: [NSLayoutConstraint.Attribute: CGFloat]
		
		public init(constants: [NSLayoutConstraint.Attribute: CGFloat]) {
			self.constants = constants
		}
		
		public subscript(attribute: NSLayoutConstraint.Attribute) -> CGFloat {
			guard let value = constants[attribute] else {
				return 0
			}
			return value
		}
	}
	
}
