//
//  MapViewModelTests.swift
//  PSISGAppTests
//
//  Created by Anudeep Gone on 28/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import PSISGApp

class MapViewModelTests: XCTestCase {
    
    var sut: MapViewModel!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        sut = MapViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        mockAPIService = nil
        sut = nil
        super.tearDown()
    }
    
    func testFetchPSI() {
        //Give empty response
        mockAPIService.psiJSON = JSON()
        
        //when
        sut.initFetchPSI()
        
        //should fetch PSI info
        XCTAssert(mockAPIService.isPSIFetched)
    }
    
    func testFetchPSIFail() {
        
        // Given a failed fetch with a certain failure
        let error = APIError.requestFailed
        
        // When
        sut.initFetchPSI()
        
        mockAPIService.fetchFail(error: error)
        
        // Sut should display predefined error message
        XCTAssertEqual( sut.alertMessage, error.localizedDescription)
        
    }
    
    func testCreatePSIData() {
        
        //Given
        mockAPIService.psiJSON = StubGenerator().stubPSI()
        let expect = XCTestExpectation(description: "reload clouser trigger")
        sut.loadMapPins = { () in
            expect.fulfill()
        }
        
        //when fetch and finish
        sut.initFetchPSI()
        mockAPIService.fetchSuccess()
        
        //Assert
        XCTAssertEqual(sut.numberOfAnnotations, 5)
        XCTAssertEqual(sut.psiDatas[0].reading.o3SubIndex, 3)
        wait(for: [expect], timeout: 1.0)
    }
    
    func testLoadingWhenFetching() {
        
        //Given
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Loading status updated")
        sut.updateLoadingStatus = { [weak sut] in
            loadingStatus = sut!.isLoading
            expect.fulfill()
        }
        
        //when fetching
        sut.initFetchPSI()
        
        // Assert
        XCTAssertTrue( loadingStatus )
        
        // When finished fetching
        mockAPIService.psiJSON = StubGenerator().stubPSI()
        mockAPIService.fetchSuccess()
        XCTAssertFalse( loadingStatus )
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testGetPSIData() {
        goToFetchPSIFinished()
        let testpsi = PSI(json: mockAPIService.psiJSON)
        let psiData = sut.getPSIData(at: 0)
        XCTAssertEqual(psiData.region.direction.rawValue, testpsi.regionMetadata[0]["name"].stringValue)
        
    }
    
}

//MARK: State control
extension MapViewModelTests {
    private func goToFetchPSIFinished() {
        mockAPIService.psiJSON = StubGenerator().stubPSI()
        sut.initFetchPSI()
        mockAPIService.fetchSuccess()
    }
}

class MockAPIService: APIServiceProtocol {
    
    var isPSIFetched = false
    var psiJSON: JSON = JSON()
    var completeClosure: ((Result<JSON, APIError>) -> ())!
    
    func request(router: Router, completion: @escaping (Result<JSON, APIError>) -> ()) {
        isPSIFetched = true
        completeClosure = completion
    }
    
    func fetchSuccess() {
        completeClosure(.success(psiJSON))
    }
    
    func fetchFail(error: APIError?) {
        completeClosure(.failure(error!))
    }
}

class StubGenerator {
    func stubPSI() -> JSON {
        let path = Bundle.main.path(forResource: "psi", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let json = try! JSON(data: data)
        return json
    }
}
