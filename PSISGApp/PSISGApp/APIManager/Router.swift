//
//  Router.swift
//  PSISGApp
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Foundation

enum Router {
    case getPSI(date: Date)
    
    var scheme: String {
        switch self {
        case .getPSI:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getPSI:
            return "api.data.gov.sg"
        }
    }
    
    var path: String {
        switch self {
        case .getPSI:
            return "/v1/environment/psi"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getPSI(let date):
            return [URLQueryItem(name: "date_time", value: date.toString())]
        }
    }
    
    var method: String {
        switch self {
        case .getPSI:
            return "GET"
        }
    }
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.parameters
        return components
    }
}
