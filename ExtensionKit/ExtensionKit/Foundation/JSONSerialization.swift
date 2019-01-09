//
//  JSONSerialization.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

public extension JSONSerialization {
	
	/// returns a serialized JSON object as a generic type from data
	///
	/// - Parameters:
	///   - data: data to be serialized
	///   - options: Options used when creating Foundation objects from JSON data
	/// - Returns: A Foundation object from the JSON data in data, or nil if an error occurs or the data could not be serialized into the generic type
	public static func jsonObject<T>(with data: Data, options: JSONSerialization.ReadingOptions = .allowFragments) -> T? {
		do {
			return try JSONSerialization.jsonObject(with: data, options: options) as? T
		} catch {
            return nil
		}
	}
	
}
