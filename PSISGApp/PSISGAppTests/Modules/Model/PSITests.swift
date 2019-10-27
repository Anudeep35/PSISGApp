//
//  PSITests.swift
//  PSISGAppTests
//
//  Created by Anudeep Gone on 28/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import PSISGApp

class PSITests: XCTestCase {
    
    var psiModelTest: PSI!
    
    override func setUp() {
        super.setUp()
        let testJSON: JSON = ["region_metadata": NSArray(),
                              "items": NSArray()]
        psiModelTest = PSI(json: testJSON)
    }
    
    override func tearDown() {
        psiModelTest =  nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(self.psiModelTest)
        XCTAssertNotNil(self.psiModelTest.regionMetadata)
        XCTAssertNotNil(self.psiModelTest.items)
    }
    
}
