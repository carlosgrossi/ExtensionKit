//
//  Dictionary.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

public extension Dictionary {
	
	mutating func union(_ dictionary: Dictionary) {
		dictionary.forEach { self.updateValue($1, forKey: $0) }
	}
	
	func sortedKeys(_ isOrderedBefore: (Key, Key) -> Bool) -> [Key] {
		return Array(self.keys).sorted(by: isOrderedBefore)
	}
	
	// Slower because of a lot of lookups, but probably takes less memory (this is equivalent to Pascals answer in an generic extension)
	func sortedKeysByValue(_ isOrderedBefore: (Value, Value) -> Bool) -> [Key] {
		return sortedKeys {
            // swiftlint:disable force_unwrapping
			isOrderedBefore(self[$0]!, self[$1]!)
            // swiftlint:enable force_unwrapping
		}
	}
    
	// swiftlint:disable closure_end_indentation
    // swiftlint:disable explicit_type_interface
	// Faster because of no lookups, may take more memory because of duplicating contents
	func keysSortedByValue(_ isOrderedBefore: (Value, Value) -> Bool) -> [Key] {
		return Array(self)
			.sorted {
				let (_, leftVar) = $0
				let (_, rightVar) = $1
				return isOrderedBefore(leftVar, rightVar)
			}
			.map {
				let (key, _) = $0
				return key
            }
	}
    // swiftlint:enable closure_end_indentation
    // swiftlint:enable explicit_type_interface
	
}

public extension Dictionary where Value: Equatable {
	
	func keys(forValue val: Value) -> [Key] {
		return self.filter { $1 == val }.map { $0.0 }
	}
	
}
