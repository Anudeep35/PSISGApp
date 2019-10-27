//
//  RegionTests.swift
//  PSISGAppTests
//
//  Created by Anudeep Gone on 28/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import PSISGApp

class RegionTests: XCTestCase {
    
    var regionModelTest: Region!
    
    override func setUp() {
        super.setUp()
        let testJSON: JSON = ["name": "west",
                              "label_location": ["latitude":1.35735,
                                                 "longitude": 103.7]]
        regionModelTest = Region(json: testJSON)
    }
    
    override func tearDown() {
        regionModelTest = nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(regionModelTest)
        XCTAssertNotNil(regionModelTest.direction)
        XCTAssertNotNil(regionModelTest.coord)
    }
    
}
