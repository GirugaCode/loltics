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
    
    var classes: [ChampClass] = [] // JUST ONE ITEM (ALL THE CLASSES 🤣) TODO FIX
    
//    var classes: [Origin] = [] // Array of all the classes
    
    var classesNeeded: [String: Int] = [:] // ['Assassin': 9, ... ]
    
    var champClassAssignement: [String: [ChampionData]] = [:] // ['Yorlde': Veigar, ... ]
    
    func buildModel() { // Fills all the variables above
        loadChamps()
        pullClasses()
    }
    
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
    
    func pullClasses() {
        TFTServices.shared.getChampsClass { (champClassGetResult) in
            switch champClassGetResult {
                
            case let .success(champClassData):
//                print(champClassData)
                
                // TODO: Get aroudn the array method without initilizers.
                self.classes = champClassData
                
            case let .failure(error):
                print(error)
                
            }
            DispatchQueue.main.async {
                self.pullOrigins()
            }
        }
    }
    
    func pullOrigins() {
        TFTServices.shared.getChampsClass { (champClassGetResult) in
            switch champClassGetResult {
                
            case let .success(champClassData):
                print()
//                print(champClassData)
                
                // TODO: Get aroudn the array method without initilizers.
                self.classes += champClassData
            case let .failure(error):
                print(error)
                
            }
            DispatchQueue.main.async {
                self.fillClassNeededArray()
            }
        }
    }
    
    func fillClassNeededArray() {
        for champClass in classes {
            var highest = 0
            
            for bonus in champClass.bonuses {

                if highest < bonus.needed {
                    highest = bonus.needed
                }
            }
            print("\(champClass.name) bonuses:", champClass.bonuses)
            classesNeeded[champClass.name] = highest
        }
        print(classesNeeded)
    }
    
//
//    func sortChampsToClasses() {
//        for champClass in classes {
//            champClassAssignement[champClass.name.lowercased()] = []
//        }
//        print(champClassAssignement.keys)
//        for champ in champs {
//            for origin in champ.origin {
//                print("Origin:", origin)
//                champClassAssignement[origin.lowercased()]!.append(champ)
//            }
//        }
//
//        print(champClassAssignement.keys.count)
//    }

    
}
