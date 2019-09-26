//
//  Items.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/24/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

//   let item = try? newJSONDecoder().decode(Item.self, from: jsonData)

import Foundation

// MARK: - ItemsValue
struct Item: Decodable {
    let key, name: String
    let type: TypeEnum
    let bonus: String
    let tier, depth: Int
    let stats: [Stat]?
    let kind: Kind
    let buildsInto: [String]?
    let champs: [Champ]
    let buildsFrom: [BuildsFrom]?
}

enum BuildsFrom: String, Decodable {
    case bfsword
    case chainvest
    case giantsbelt
    case needlesslylargerod
    case negatroncloak
    case recurvebow
    case spatula
    case tearofthegoddess
}

enum Champ: String, Decodable {
    case ashe
    case yasuo
    case zed
}

enum Kind: String, Decodable {
    case advanced
    case basic
}

// MARK: - Stat
struct Stat: Decodable{
    let name: String?
    let title: String
    let amount: String?
}

enum TypeEnum: String, Decodable {
    case defensive
    case offensive
    case utility
}
