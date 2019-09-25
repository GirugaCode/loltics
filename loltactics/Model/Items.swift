//
//  Items.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/24/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

//   let item = try? newJSONDecoder().decode(Item.self, from: jsonData)

import Foundation

// MARK: - Item
struct Item: Decodable {
    let key, name: String
    let type: String
    let bonus: String
    let tier, depth: Int
    let stats: [Stat]?
    let kind: String
    let buildsInto: [String]?
    let champs: [String]?
    let buildsFrom: [String]?
}

// MARK: - Stat
struct Stat: Codable {
    let name: String?
    let title: String
    let amount: String?
}
