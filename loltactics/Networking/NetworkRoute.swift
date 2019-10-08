//
//  NetworkRoute.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/25/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

public enum NetworkRoute: String {
    // Enum for the TFT API URLs
    case itemList = "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/items.json"
    case championList = "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/champions.json"
}
