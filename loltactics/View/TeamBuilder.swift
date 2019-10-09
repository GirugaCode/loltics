//
//  TeamBuilder.swift
//  loltactics
//
//  Created by timofey makhlay on 10/8/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

class TeamBuilder {
/*
     Given first three champs, find and return the Best team (9 champions) based on:
     • most different classes we can have.
*/
    var champs: [ChampionData] = []
    var champClasses: [ChampClass] = []
    
    func loadChamps() {
        TFTServices.shared.getChamps() { (champGetResult) in
            switch champGetResult {
                
            case let .success(champData):
                self.champs = champData
                
            case let .failure(error):
                print(error)

            }
            DispatchQueue.main.async {
                self.countChamps()
            }
        }
    }
    
    func countChamps() {
        print(champs.count)
    }
    
    func buildClassDict() {
        TFTServices.shared.getChampsClass { (champClassGetResult) in
            switch champClassGetResult {
                
            case let .success(champClassData):
                print(champClassData)
                self.champClasses.append(champClassData)
            case let .failure(error):
                print(error)
                
            }
            DispatchQueue.main.async {
                print("HEREEE",self.champClasses)
            }
        }
    }
    
}
