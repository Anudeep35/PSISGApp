//
//  APIService.swift
//  PSISGApp
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Foundation
import SwiftyJSON

enum APIError: Error {
    case requestFailed
    case invalidData
    case responseUnsuccessful
    case jsonConversionFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol APIServiceProtocol {
    func request(router: Router, completion: @escaping (Result<JSON, APIError>) -> ())
}

class APIService: APIServiceProtocol {
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    func request(router: Router, completion: @escaping (Result<JSON, APIError>) -> ()) {
        
        guard let url = router.components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        dataTask = defaultSession.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSON(data: data)
                        completion(.success(json))
                    } catch {
                        completion(.failure(.jsonConversionFailure))
                    }
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                completion(.failure(.responseUnsuccessful))
            }
        }
        dataTask?.resume()
    }
}
