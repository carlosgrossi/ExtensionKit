//
//  URLSession.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

public extension URLSession {
	
	enum URLSessionError: Error {
		case dataUnwrapError
		case URLIsNil
	}
	
	/**
	Abstraction layer of NSURLSession dataTaskWithRequest method that takes a URL and calls a completition handler when finished
	
	- Parameter url:   The URL that will be fetch from the network by NSURLSession
	- Parameter completitionHandler: The code that will be called when the data session is finished, it handles the same NSData, NSURLResponse and NSError retrieved by th NSURLSession.
	*/
	static func dataTask(with url: URL?, requestMethod: String? = nil, requestValues: [String: String]? = nil, completitionHandler:@escaping (Data?, URLResponse?, Error?) -> Void) {
		guard let url = url else {
			completitionHandler(nil, nil, URLSessionError.URLIsNil)
			return
		}
		
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
		
		let urlRequest = URLRequest.urlRequest(with: url, requestMethod: requestMethod, requestValues: requestValues)
		let urlSession = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
			completitionHandler(data, response, error)
		})
		urlSession.resume()
	}
	
	/**
	Checks if a NSURLSession dataTask returned valid data
	
	- Parameter data:   The NSData returned by a NSURLSession.dataTaskWith...
	- Parameter response: The NSURLResponse returned by a NSURLSession.dataTaskWith... (currently has no use)
	- Parameter error: The NSError returned by a NSURLSession.dataTaskWith...
	- Parameter completitionHandler: The code that will be called when the validation is finished,
	it has the original data and an error that can be the same error returned by the NSURLSession or one generated by the method.
	*/
	static func validateURLSessionDataTask(_ data: Data?, response: URLResponse?, error: NSError?, completitionHandler:(_ data: Data, _ error: Error?) -> Void) {
		if error == nil {
			if let evaluatedData = data {
				completitionHandler(evaluatedData, nil)
			} else {
				completitionHandler(Data(), URLSessionError.dataUnwrapError)
			}
		} else {
			completitionHandler(Data(), error)
		}
	}
	
}
