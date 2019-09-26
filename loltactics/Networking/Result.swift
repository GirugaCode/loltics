//
//  Result.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/25/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

// Finds the result of the network request to ensure its either sucessful or failure.

enum Result<T> {
    case success(T)
    case failure(Error)
}
