//
//  PSIReadingTests.swift
//  PSISGAppTests
//
//  Created by Anudeep Gone on 28/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import PSISGApp

class PSIReadingTests: XCTestCase {
    
    var psiReadingModelTest: PSIReading!
    
    override func setUp() {
        super.setUp()
        let testJSON: JSON = ["o3_sub_index": ["west": 11],
                              "pm10_twenty_four_hourly": ["west": 32],
                              "pm10_sub_index": ["west": 32],
                              "co_sub_index": ["west": 5],
                              "pm25_twenty_four_hourly": ["west": 17],
                              "so2_sub_index": ["west": 6],
                              "co_eight_hour_max": ["west": 0.55],
                              "no2_one_hour_max": ["west": 47],
                              "so2_twenty_four_hourly": ["west": 10],
                              "pm25_sub_index": ["west": 57],
                              "psi_twenty_four_hourly": ["west": 57],
                              "o3_eight_hour_max": ["west": 25]]
        self.psiReadingModelTest = PSIReading(json: testJSON, forDirection: "west")
    }
    
    override func tearDown() {
        self.psiReadingModelTest = nil
        super.tearDown()
    }
    
    func testInitialization(){
        XCTAssertNotNil(self.psiReadingModelTest)
        XCTAssertNotNil(self.psiReadingModelTest.o3SubIndex)
        XCTAssertNotNil(self.psiReadingModelTest.pm10TwentyFourHourly)
        XCTAssertNotNil(self.psiReadingModelTest.pm10SubIndex)
        XCTAssertNotNil(self.psiReadingModelTest.coSubIndex)
        XCTAssertNotNil(self.psiReadingModelTest.pm25TwentyFourHourly)
        XCTAssertNotNil(self.psiReadingModelTest.so2_sub_index)
        XCTAssertNotNil(self.psiReadingModelTest.coEightHourMax)
        XCTAssertNotNil(self.psiReadingModelTest.no2OneHourMax)
        XCTAssertNotNil(self.psiReadingModelTest.so2TwentyFourHourly)
        XCTAssertNotNil(self.psiReadingModelTest.pm25SubIndex)
        XCTAssertNotNil(self.psiReadingModelTest.psiTwentyFourHourly)
        XCTAssertNotNil(self.psiReadingModelTest.o3EightHourMax)
    }
    
}
