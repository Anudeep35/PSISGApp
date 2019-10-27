//
//  PSIMapViewControllerSpec.swift
//  PSISGAppTests
//
//  Created by Anudeep Gone on 28/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Foundation
import Quick
import Nimble
import UIKit

@testable import PSISGApp

class MapViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("MapViewController"){
            var subject: PSIMapViewController!
            var mockAPIService: MockAPIService!
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                subject = (storyboard.instantiateViewController(withIdentifier: "PSIMapViewController") as! PSIMapViewController)
                mockAPIService = MockAPIService()
                subject.viewModel = MapViewModel(apiService: mockAPIService)
                _ = subject.view
            }
            
            context("When view is loaded"){
                it("should have a mapview") {
                    expect(subject.mapView).toNot(beNil())
                }
                
                it("should init viewModel") {
                    expect(subject.viewModel).toNot(beNil())
                }
                
                it("should fetch psi data") {
                    expect(mockAPIService.isPSIFetched).to(beTrue())
                }
            }
            
        }
    }
    
}
