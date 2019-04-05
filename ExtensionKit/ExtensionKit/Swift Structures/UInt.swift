//
//  UInt.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

public extension UInt {
	
	init?(exactly: UInt?) {
		guard let exactly = exactly else { return nil }
		self.init(exactly: exactly)
	}
	
	init?(hex: String) {
		self.init(exactly: UInt(hex, radix: 16))
	}
	
}
