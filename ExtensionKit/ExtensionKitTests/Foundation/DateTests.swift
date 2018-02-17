//
//  DateTests.swift
//  ExtensionKitTests
//
//  Created by Carlos Grossi on 17/02/18.
//  Copyright © 2018 Carlos Grossi. All rights reserved.
//

import XCTest

class DateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTimeIntervalFromDouble() {
        let timeInterval = Date().timeIntervalSince1970
        XCTAssertEqual(Date.timeInterval(Double(timeInterval)), timeInterval)
        XCTAssertNotEqual(Date.timeInterval(Double(timeInterval + 1)), timeInterval)
    }
    
    func testTimeAgo() {
        XCTAssertEqual(Date().timeAgo(usingNumericDates: true), "Just now")
    }
    
}
