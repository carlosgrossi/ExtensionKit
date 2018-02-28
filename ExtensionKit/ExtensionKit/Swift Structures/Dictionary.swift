//
//  Dictionary.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

public extension Dictionary {
	
	public mutating func union(_ dictionary: Dictionary) {
		dictionary.forEach { self.updateValue($1, forKey: $0) }
	}
	
	public func union(_ dictionary: Dictionary) -> Dictionary {
		let dictionary = dictionary
		return dictionary.union(self)
	}
	
	public func sortedKeys(_ isOrderedBefore: (Key, Key) -> Bool) -> [Key] {
		return Array(self.keys).sorted(by: isOrderedBefore)
	}
	
	// Slower because of a lot of lookups, but probably takes less memory (this is equivalent to Pascals answer in an generic extension)
	public func sortedKeysByValue(_ isOrderedBefore: (Value, Value) -> Bool) -> [Key] {
		return sortedKeys {
            // swiftlint:disable force_unwrapping
			isOrderedBefore(self[$0]!, self[$1]!)
            // swiftlint:enable force_unwrapping
		}
	}
    
	// swiftlint:disable closure_end_indentation
	// Faster because of no lookups, may take more memory because of duplicating contents
	public func keysSortedByValue(_ isOrderedBefore: (Value, Value) -> Bool) -> [Key] {
		return Array(self)
			.sorted {
				let (_, lv) = $0
				let (_, rv) = $1
				return isOrderedBefore(lv, rv)
			}
			.map {
				let (k, _) = $0
				return k
            }
	}
    // swiftlint:enable closure_end_indentation
	
}

public extension Dictionary where Value: Equatable {
	
	public func keys(forValue val: Value) -> [Key] {
		return self.filter { $1 == val }.map { $0.0 }
	}
	
}
