//
//  NetworkResponse.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/25/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

struct NetworkResponse {
    // Recieves the Network Response from the TFT API
    
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<String>{
        
        guard let res = response else { return Result.failure(NetworkError.UnwrappingError)}
        
        switch res.statusCode {
        case 200...299: return .success(NetworkError.success.rawValue)
        case 401: return .failure(NetworkError.authenticationError)
        case 400...499: return .failure(NetworkError.badRequest)
        case 500...599: return .failure(NetworkError.serverSideError)
        default: return .failure(NetworkError.failed)
        }
    }
    
}
