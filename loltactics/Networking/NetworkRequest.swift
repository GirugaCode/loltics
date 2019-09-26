//
//  NetworkRequest.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/25/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

public typealias HTTPParameters = [String: Any]?

struct NetworkRequest {
    
    // Sending Network Request to the TFT API
    
    static func configureHTTPRequest(from route: NetworkRoute, with parameters: HTTPParameters) throws -> URLRequest {
        
        guard let url = URL(string: route.rawValue) else { fatalError("Error while unwrapping url")}
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        try configureParameters(parameters: parameters, request: &request)
        
        return request
    }
    
    
    static func configureParameters(parameters: HTTPParameters?, request: inout URLRequest) throws {
        
        do {
            if let unwrappedParameters = parameters {
                try encodeParameters(for: &request, with: unwrappedParameters)
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    

    static func encodeParameters(for urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        if parameters == nil { return }
        guard let url = urlRequest.url, let unwrappedParameters = parameters else { throw NetworkError.missingURL }
        
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !unwrappedParameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in unwrappedParameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
    }
}
