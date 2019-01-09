//
//  URL.swift
//  ExtensionKit
//
//  Created by Carlos Grossi on 16/02/18.
//  Copyright © 2018 Carlos Grossi. All rights reserved.
//

import Foundation

public extension URL {
    
    public init?(string: String, args: [CVarArg]) {
        guard let string = String(format: string, arguments: args).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        self.init(string: string)
    }
    
    public init?(string: String?) {
        guard let string = string else { return nil }
        self.init(string: string)
    }
    
    public func queryParameter(named parameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == parameterName })?.value
    }
    
}
