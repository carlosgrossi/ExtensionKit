//
//  NotificationCenterTests.swift
//  ExtensionKitTests
//
//  Created by Carlos Grossi on 28/02/18.
//  Copyright © 2018 Carlos Grossi. All rights reserved.
//

import XCTest

class NotificationCenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        NotificationCenter.default.addObserver(self, selector: #selector(testPostNotification), name: NSNotification.Name(rawValue: "testPostNotification"), object: self)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    let expectation: XCTestExpectation = XCTestExpectation(description: "Receive notification from Notification Center")
    
    func testPost() {
        XCTAssertNoThrow({ NotificationCenter.default.post(name: NSNotification.Name(rawValue: "testPostNotification"), object: self, userInfo: ["Key": "Value"]) })
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "testPostNotification"), object: self, userInfo: ["Key": "Value"])
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPostNotification() {
        expectation.fulfill()
    }
    
}
