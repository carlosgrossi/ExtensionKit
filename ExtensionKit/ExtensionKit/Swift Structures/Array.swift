//
//  Array.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

public extension Array where Element: Equatable {
	
	public mutating func removeDuplicates() -> [Element] {
		var result = [Element]()
		for value in self {
			if result.contains(value) == false {
				result.append(value)
			}
		}
		self = result
		return self
	}
	
	public func randomElement<T>() -> T? {
		let index = arc4random_uniform(UInt32(self.count))
		return self[Int(index)] as? T
	}
	
}
