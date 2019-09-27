//
//  Champion.swift
//  loltactics
//
//  Created by timofey makhlay on 9/26/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

// MARK: - ChampionValue
struct Champion: Decodable {
    let id, key, name: String
    let origin, championClass: [String]
    let cost: Int
    let ability: Ability
    let stats: Stats
    let items: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, key, name, origin
        case championClass = "class"
        case cost, ability, stats, items
    }
}

// MARK: - Ability
struct Ability: Decodable {
    let name, abilityDescription: String
    let type: Type
    let manaCost, manaStart: Int?
    let stats: [StatType]
    let items: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case abilityDescription = "description"
        case type, manaCost, manaStart, stats, items
    }
}

// MARK: - Stat
struct StatType: Codable {
    let type, value: String
}

enum Type: String, Codable {
    case active = "Active"
    case passive = "Passive"
}

// MARK: - Stats
struct Stats: Codable {
    let offense: Offense
    let defense: Defense
}

// MARK: - Defense
struct Defense: Codable {
    let health, armor, magicResist: Int
}

// MARK: - Offense
struct Offense: Codable {
    let damage: Int
    let attackSpeed: Double
    let dps, range: Int
}
