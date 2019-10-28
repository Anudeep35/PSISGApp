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
            
            context("when psi info is fetched"){
                beforeEach {
                    mockAPIService.psiJSON = StubGenerator().stubPSI()
                    mockAPIService.fetchSuccess()
                }
                it("should load the map with annotations") {
                    waitUntil(timeout: 2) { done in
                        print("1: MapView annotations \(subject.mapView.annotations.count)")
                        expect(subject.mapView.annotations.count).to(equal(5))
                        done()
                    }
                }
                it("should have annotation of type PSIAnnotation") {
                    waitUntil(timeout: 2) { done in
                        print("1: MapView annotations \(subject.mapView.annotations.count)")
                    expect(subject.mapView.annotations[0]).to(beAKindOf(PSIAnnotation.self))
                        done()
                    }
                    
                }
                it("should have annotation title") {
                    waitUntil(timeout: 2) { done in
                        let annotation = subject.mapView.annotations[0]
                        expect(annotation.title!).to(satisfyAnyOf(
                            equal(subject.viewModel.getPSIData(at: 0).region.direction.rawValue),
                            equal(subject.viewModel.getPSIData(at: 1).region.direction.rawValue),
                            equal(subject.viewModel.getPSIData(at: 2).region.direction.rawValue),
                            equal(subject.viewModel.getPSIData(at: 3).region.direction.rawValue),
                            equal(subject.viewModel.getPSIData(at: 4).region.direction.rawValue)
                        ))
                        done()
                    }
                    
                }
                it("should have annotation subtitle") {
                    waitUntil(timeout: 2) { done in
                        let annotation = subject.mapView.annotations[0]
                        expect(annotation.subtitle!).to(satisfyAnyOf(
                            equal(subject.viewModel.getPSIData(at: 0).descriptionText()),
                            equal(subject.viewModel.getPSIData(at: 1).descriptionText()),
                            equal(subject.viewModel.getPSIData(at: 2).descriptionText()),
                            equal(subject.viewModel.getPSIData(at: 3).descriptionText()),
                            equal(subject.viewModel.getPSIData(at: 4).descriptionText())
                        ))
                        done()
                    }
                    
                }
                it("should have annotation coordinate") {
                    waitUntil(timeout: 2) { done in
                        let annotation = subject.mapView.annotations[0]
                        expect(annotation.coordinate.latitude).to(satisfyAnyOf(
                            equal(subject.viewModel.getPSIData(at: 0).region.coord.latitude),
                            equal(subject.viewModel.getPSIData(at: 1).region.coord.latitude),
                            equal(subject.viewModel.getPSIData(at: 2).region.coord.latitude),
                            equal(subject.viewModel.getPSIData(at: 3).region.coord.latitude),
                            equal(subject.viewModel.getPSIData(at: 4).region.coord.latitude)
                        ))
                        expect(annotation.coordinate.longitude).to(satisfyAnyOf(
                            equal(subject.viewModel.getPSIData(at: 0).region.coord.longitude),
                            equal(subject.viewModel.getPSIData(at: 1).region.coord.longitude),
                            equal(subject.viewModel.getPSIData(at: 2).region.coord.longitude),
                            equal(subject.viewModel.getPSIData(at: 3).region.coord.longitude),
                            equal(subject.viewModel.getPSIData(at: 4).region.coord.longitude)
                        ))
                        done()
                    }
                    
                }
            }
            
        }
    }
    
}
