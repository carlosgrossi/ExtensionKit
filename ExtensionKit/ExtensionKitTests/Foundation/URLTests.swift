//
//  URLTests.swift
//  ExtensionKitTests
//
//  Created by Carlos Grossi on 16/02/18.
//  Copyright © 2018 Carlos Grossi. All rights reserved.
//

import XCTest
@testable import ExtensionKit

class URLTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testInitWithStringAndArgs() {
        XCTAssertNotNil(URL(string: "http://www.google.com/search?q=%@", args: ["Swift"]))
        XCTAssertEqual(URL(string: "http://www.google.com/search?q=%@", args: ["Swift"])?.absoluteString, URL(string: "http://www.google.com/search?q=Swift")?.absoluteString)
        XCTAssertEqual(URL(string: "http://192.168.100.%d/", args: [101])?.absoluteString, URL(string: "http://192.168.100.101/")?.absoluteString)
    }
    
    func testInitWithOptionalString() {
        let googleURL: String? = "http://www.google.com/"
        let appleURL: String? = "http://www.apple.com/"
        
        XCTAssertNil(URL(string: nil))
        XCTAssertNotNil(URL(string: googleURL))
        XCTAssertEqual(URL(string: googleURL)?.absoluteString, URL(string: "http://www.google.com/")?.absoluteString)
        XCTAssertNotEqual(URL(string: googleURL)?.absoluteString, URL(string: appleURL)?.absoluteString)
    }
    
    func testQueryParameter() {
        let sampleURL: URL? = URL(string: "http://www.google.com/search?q=Swift&as_epq=4.0")
        
        XCTAssertNotNil(sampleURL)
        XCTAssertNil(sampleURL?.queryParameter(named: "unexistentParameter"))
        XCTAssertNotNil(sampleURL?.queryParameter(named: "q"))
        XCTAssertEqual(sampleURL?.queryParameter(named: "q"), "Swift")
        XCTAssertEqual(sampleURL?.queryParameter(named: "as_epq"), "4.0")
    }
    
}
