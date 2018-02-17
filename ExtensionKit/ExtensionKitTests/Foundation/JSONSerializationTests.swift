//
//  JSONSerializationTests.swift
//  ExtensionKitTests
//
//  Created by Carlos Grossi on 17/02/18.
//  Copyright © 2018 Carlos Grossi. All rights reserved.
//

import XCTest

// swiftlint:disable force_unwrapping
class JSONSerializationTests: XCTestCase {
    
    var jsonStringDict: String = "{ \"key\": \"value\" }"
    var jsonStringArray: String = "[ \"value\" ]"
    var jsonDataDict: Data = Data()
    var jsonDataArray: Data = Data()
    var serializedJsonDictionary: Dictionary<AnyHashable, String>?
    var serializedJsonArray: Array<String>?
    
    override func setUp() {
        super.setUp()
        
        jsonDataDict = jsonStringDict.data(using: .utf8)!
        jsonDataArray = jsonStringArray.data(using: .utf8)!
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testJSONObjectWithData() {
        serializedJsonDictionary = JSONSerialization.jsonObject(with: jsonDataDict)
        serializedJsonArray = JSONSerialization.jsonObject(with: jsonDataDict)

        XCTAssertNil(serializedJsonArray)
        XCTAssertNotNil(serializedJsonDictionary)
        XCTAssertEqual(serializedJsonDictionary?["key"], "value")

        serializedJsonDictionary = JSONSerialization.jsonObject(with: jsonDataArray)
        serializedJsonArray = JSONSerialization.jsonObject(with: jsonDataArray)

        XCTAssertNil(serializedJsonDictionary)
        XCTAssertNotNil(serializedJsonArray)
        XCTAssertEqual(serializedJsonArray?.first, "value")

        serializedJsonArray = JSONSerialization.jsonObject(with: "Not JSON".data(using: .utf8)!)
        XCTAssertNil(serializedJsonArray)
    }

    func testPerformanceJSONObjectWithData() {
        self.measure {
            let _: Dictionary<AnyHashable, String>? = JSONSerialization.jsonObject(with: jsonDataDict)
        }
    }
    
}
