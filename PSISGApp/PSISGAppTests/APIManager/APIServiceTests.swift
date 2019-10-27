//
//  APIServiceTests.swift
//  PSISGAppTests
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import XCTest

@testable import PSISGApp

class APIServiceTests: XCTestCase {
    
    var sut: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testValidCallToPSI() {
        // given
        let url =
            URL(string: "https://api.data.gov.sg/v1/environment/psi")
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }
    
}
