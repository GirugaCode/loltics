//
//  Items.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/24/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//


import Foundation

// MARK: - ItemsValue
//struct Item: Decodable {
//    let key, name: String
//    let type: TypeEnum
//    let itemsBonus: String?
//    let tier, depth: Int
//    let stats: [Stat]?
//    let kind: Kind
//    let buildsInto: [String]?
//    let champs: [Champ]
//    let buildsFrom: [BuildsFrom]?
//    let bonus: String?
//}
//
//enum BuildsFrom: String, Decodable {
//    case bfsword = "bfsword"
//    case chainvest = "chainvest"
//    case giantsbelt = "giantsbelt"
//    case needlesslylargerod = "needlesslylargerod"
//    case negatroncloak = "negatroncloak"
//    case recurvebow = "recurvebow"
//    case spatula = "spatula"
//    case tearofthegoddess = "tearofthegoddess"
//    case sparringgloves = "sparringgloves"
//}
//
//enum Champ: String, Decodable {
//    case ashe
//    case yasuo
//    case zed
//}
//
//enum Kind: String, Decodable {
//    case advanced
//    case basic
//}
//
//// MARK: - Stat
//struct Stat: Decodable{
//    let name: String?
//    let title: String
//    let amount: String?
//}
//
//enum TypeEnum: String, Decodable {
//    case defensive
//    case offensive
//    case typeOffensive
//    case utility
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let item = try? newJSONDecoder().decode(Item.self, from: jsonData)

// MARK: - ItemValue
struct ItemValue: Codable {
    let key, name: String
    let type: TypeEnum
    let itemBonus: String?
    let tier, depth: Int
    let stats: [Stat]?
    let kind: Kind
    let buildsInto: [String]?
    let champs: [Champ]
    let buildsFrom: [BuildsFrom]?
    let bonus: String?

    enum CodingKeys: String, CodingKey {
        case key, name, type
        case itemBonus = "bonus"
        case tier, depth, stats, kind, buildsInto, champs, buildsFrom
        case bonus = "Bonus"
    }
}

enum BuildsFrom: String, Codable {
    case bfsword = "bfsword"
    case chainvest = "chainvest"
    case giantsbelt = "giantsbelt"
    case needlesslylargerod = "needlesslylargerod"
    case negatroncloak = "negatroncloak"
    case recurvebow = "recurvebow"
    case sparringgloves = "sparringgloves"
    case spatula = "spatula"
    case tearofthegoddess = "tearofthegoddess"
}

enum Champ: String, Codable {
    case ashe = "Ashe"
    case yasuo = "Yasuo"
    case zed = "Zed"
}

enum Kind: String, Codable {
    case advanced = "advanced"
    case basic = "basic"
}

// MARK: - Stat
struct Stat: Codable {
    let name: String?
    let title: String
    let amount: String?
}

enum TypeEnum: String, Codable {
    case defensive = "Defensive"
    case offensive = "Offensive"
    case typeOffensive = "offensive"
    case utility = "Utility"
}

typealias Item = [String: ItemValue]
