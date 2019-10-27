//
//  RouterSpec.swift
//  PSISGAppTests
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Quick
import Nimble

@testable import PSISGApp

class RouterSpec: QuickSpec {
    
    override func spec() {
        var sut: Router!
        var urlcomponents: URLComponents!
        
        context("when calling PSI api") {
            beforeEach {
                sut = Router.getPSI(date: Date())
                urlcomponents = sut.components
            }
            
            it("should be GET request"){
                expect(sut.method).to(equal("GET"))
            }
            
            it("should be correct scheme"){
                expect(urlcomponents.scheme).to(equal("https"))
            }
            
            it("should be correct host"){
                expect(urlcomponents.host).to(equal("api.data.gov.sg"))
            }
            
            it("should point to correct end point"){
                expect(urlcomponents.path).to(equal("/v1/environment/psi"))
            }
            
            it("should append date_time as query item"){
                expect(urlcomponents.queryItems![0].name).to(equal("date_time"))
            }
        }
        
    }

}
