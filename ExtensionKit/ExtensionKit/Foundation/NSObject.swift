//
//  Error.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

public extension NSObject {
	
	/// Safely returns the value for the property identified by a given key or nil.
	/// The search pattern that valueForKey: uses to find the correct value to return is described in Accessor Search Patterns in Key-Value Coding Programming Guide.
	///
	/// - Parameter key: The name of one of the receiver's properties.
	/// - Returns: The value for the property identified by key.
    public func safeValue<T>(forKey key: String) -> T? {
        let copy = Mirror(reflecting: self)
        for child in copy.children {
            if let label = child.label {
                if label == key {
                    return value(forKey: label) as? T
                }
            }
        }
        return nil
    }
	
	/// Safely sets the property of the receiver specified by a given key to a given value.
	/// If key identifies a to-one relationship, relate the object specified by value to the receiver, unrelating the previously related object if there was one.
    /// Given a collection object and a key that identifies a to-many relationship, relate the objects contained in the collection to the receiver,
    /// unrelating previously related objects if there were any.
	/// The search pattern that setValue:forKey: uses is described in Accessor Search Patterns in Key-Value Coding Programming Guide.
	///
	/// - Parameters:
	///   - value: The value for the property identified by key.
	///   - key: The name of one of the receiver's properties.
    public func setValue<T>(_ value: T, forKey key: String) {
        let copy = Mirror(reflecting: self)
        for child in copy.children {
            if let label = child.label {
                if label == key {
                    setValue(value, forKey: key)
                }
            }
        }
    }
	
}
