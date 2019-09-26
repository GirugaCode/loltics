//
//  NetworkError.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/25/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    // Edge Cases for errors while doing URL Sessions
    
    case parametersNil = "Error Found : Parameters URL were nil."
    case encodingFailed = "Error Found : Parameter Encoding failed."
    case decodingFailed = "Error Found : Unable to Decode the data."
    case missingURL = "Error Found : The URL is nil."
    case couldNotParse = "Error Found : Unable to parse the JSON response."
    case noData = "Error Found : The data from API is Nil."
    case FragmentResponse = "Error Found : The API's response's body has fragments."
    case UnwrappingError = "Error Found : Unable to unwrape the data."
    case dataTaskFailed = "Error Found : The Data Task object failed."
    case success = "Successful Network Request"
    case authenticationError = "Error Found : You must be Authenticated"
    case badRequest = "Error Found : Bad Request"
    case pageNotFound = "Error Found : Page/Route rquested not found."
    case failed = "Error Found : Network Request failed"
    case serverSideError = "Error Found : Server error"
    case headersNil = "Error Found: No Header"
}
