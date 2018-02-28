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
		var constants: [NSLayoutAttribute: CGFloat]
		
		public init(constants: [NSLayoutAttribute: CGFloat]) {
			self.constants = constants
		}
		
		public subscript(attribute: NSLayoutAttribute) -> CGFloat {
			guard let value = constants[attribute] else {
				return 0
			}
			return value
		}
	}
	
}
