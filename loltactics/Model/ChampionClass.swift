//
//  ChampionClass.swift
//  loltactics
//
//  Created by timofey makhlay on 10/8/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

// MARK: - ChampClass
class ChampClass: Codable {
    let assassin, blademaster, brawler, elementalist: Origin
    let guardian, gunslinger, knight, ranger: Origin
    let shapeshifter, sorcerer: Origin
    
    init(assassin: Origin, blademaster: Origin, brawler: Origin, elementalist: Origin, guardian: Origin, gunslinger: Origin, knight: Origin, ranger: Origin, shapeshifter: Origin, sorcerer: Origin) {
        self.assassin = assassin
        self.blademaster = blademaster
        self.brawler = brawler
        self.elementalist = elementalist
        self.guardian = guardian
        self.gunslinger = gunslinger
        self.knight = knight
        self.ranger = ranger
        self.shapeshifter = shapeshifter
        self.sorcerer = sorcerer
    }
}

// MARK: - Origin
class Origin: Codable {
    let key, name: String
    let originDescription: String?
    let accentChampionImage: String
    let bonuses: [Bonus]
    
    enum CodingKeys: String, CodingKey {
        case key, name
        case originDescription = "description"
        case accentChampionImage, bonuses
    }
    
    init(key: String, name: String, originDescription: String?, accentChampionImage: String, bonuses: [Bonus]) {
        self.key = key
        self.name = name
        self.originDescription = originDescription
        self.accentChampionImage = accentChampionImage
        self.bonuses = bonuses
    }
}

// MARK: - Bonus
class Bonus: Codable {
    let needed: Int
    let effect: String
    
    init(needed: Int, effect: String) {
        self.needed = needed
        self.effect = effect
    }
}
