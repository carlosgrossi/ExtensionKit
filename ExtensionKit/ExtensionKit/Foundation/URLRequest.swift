//
//  URLRequest.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

public extension URLRequest {
	
	/**
	Build and returns a NSURLRequest based on a NSURL
	
	- parameter url:           URL used to build the request
	- parameter requestMethod: HTTPMethod attributed to the reques
	- parameter requestValues: [Key: Value] used on HTTPMethod to build the request
	
	- returns: URLRequest ready to be used on a remote connection method
	*/
	static func urlRequest(with url: URL, requestMethod: String? = nil, requestValues: [String: String]? = nil) -> URLRequest {
		let mutableURLRequest = NSMutableURLRequest(url: url)
		
		if let requestMethod = requestMethod {
			if let requestValues = requestValues {
				
				mutableURLRequest.httpMethod = requestMethod
				for requestValue in requestValues {
					mutableURLRequest.setValue(requestValue.1, forHTTPHeaderField: requestValue.0)
				}
			}
		}
		
		return mutableURLRequest as URLRequest
	}
	
}
