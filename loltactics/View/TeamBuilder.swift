//
//  TeamBuilder.swift
//  loltactics
//
//  Created by timofey makhlay on 10/8/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import Foundation

// VIEW MODEL 
class TeamBuilder {
/*
     Given first three champs, find and return the Best team (9 champions) based on:
     • most different classes we can have.
*/
    var champs: [ChampionData] = []
    
    var classes: [ChampClass] = [] // JUST ONE ITEM (ALL THE CLASSES 🤣) TODO FIX
    
    var classesNeeded: [String: Int] = [:] // ['Assassin': 9, ... ]
    
    var teamClassNeeded: [Int: [String]] = [3: [], 6: [], 9: [], 2: [], 1: [], 4: []] // [3: ["Elementalist", "Pirate"], 2:...
    
    var champClassAssignement: [String: [ChampionData]] = [:] // ['Yorlde': Veigar, ... ]
    
    var champsClass: [String: [String]] = [:] // ['Aatrox' : ['Demon', 'BladeMaster'], 'Yasuo':['Exile','BladeMaster']...
    
    func buildModel() { // Fills all the variables above
        loadChamps()
        pullClasses()
    }
    
    func loadChamps() {
        TFTServices.shared.getChamps() { (champGetResult) in
            switch champGetResult {
                
            case let .success(champData):
                self.champs = champData
//                print(self.champs)
            case let .failure(error):
                print(error)

            }
            DispatchQueue.main.async {
                self.countChamps() // prints the number of champs
                
                self.pullClasses() // this calls to the pullOrigins() inside

            }
        }
    }
    
    func countChamps() {
        print("Number of champs:",champs.count, " == 57?")
    }
    
    func pullClasses() {
        TFTServices.shared.getChampsClass { (champClassGetResult) in
            switch champClassGetResult {
                
            case let .success(champClassData):
//                print(champClassData)
                
                // TODO: Get aroudn the array method without initilizers.
                self.classes = champClassData
//                print("pulled classes", self.classes)
                
            case let .failure(error):
                print(error)
                
            }
            DispatchQueue.main.async {
                self.pullOrigins()
            }
        }
    }
    
    func pullOrigins() {
        TFTServices.shared.getChampsOrigin { (champClassGetResult) in
            switch champClassGetResult {
                
            case let .success(champClassData):
//                print("These should be the origins:",champClassData[0].name)
                
                // TODO: Get aroudn the array method without initilizers.
                self.classes += champClassData
//                print("pulled origins", self.classes)
                
            case let .failure(error):
                print(error)
                
            }
            DispatchQueue.main.async {
                // TODO: Move this for after pulling origins and classes.
                NotificationCenter.default.post(name: Notification.Name("loadedChamps"), object: nil) // after havaing pulled classes / origins / championss
                
                self.fillClassNeededArray()
            }
        }
    }
    
    // Create all the data arrays.
    func fillClassNeededArray() {
//        print("filling classes array")
        for champClass in classes {
            var highest = 0
            print(champClass.name)
            for bonus in champClass.bonuses {

                if highest < bonus.needed {
                    highest = bonus.needed
//                    teamClassNeeded[highest] = []
//                    print(teamClassNeeded)
                }
            }
//            print("\(champClass.name) bonuses:", champClass.bonuses)
            teamClassNeeded[highest]!.append(champClass.name)
            print(teamClassNeeded)
            classesNeeded[champClass.name] = highest
        }
//        print(classesNeeded)
        sortChampsToClasses()
    }
    

    func sortChampsToClasses() {
        for champClass in classes {
            champClassAssignement[champClass.name.lowercased()] = []
        }
//        print(champClassAssignement.keys)
        for champ in champs {
            champsClass[champ.name] = []
            for origin in champ.origin {
//                print("Champ:", champ, "Origin:", origin)
                champClassAssignement[origin.lowercased()]!.append(champ)
                champsClass[champ.name]!.append(origin)
            }
            // TODO: The same for classes
            for championClass in champ.championClass {
                //                print("Champ:", champ, "Origin:", origin)
                champClassAssignement[championClass.lowercased()]!.append(champ)
                champsClass[champ.name]!.append(championClass)
            }
        }
        

//        print(champClassAssignement.keys.count, champClassAssignement)
        for key in champClassAssignement.keys {
            print(key, champClassAssignement[key]!.count)
        }
        
//        print(champsClass)
        
        buildATeam(starters: [champs[5], champs[7], champs[20]])
    }
    
    func buildATeam(starters: [ChampionData]) {
        var team: [ChampionData] = []
        
        var teamClasses: [String] = []
        
        var slots = 9
        
        var builderTeam: [String:Int] = [:]
        
        var highest: (String, Int) = ("Classname", 0)
        
        if starters.count > 3 {
            // TODO: Throw error if too many champs given
            print("Too many")
        } else {
            
            // Adding the base Team
            for starter in starters {
//                print(champsClass[starter.name])
                team.append(starter) // Appending selected champ to the team
                teamClasses += (champsClass[starter.name]!) // Adding the must have champion's classes
                
                slots -= 1
            }
            
            for c in teamClasses {
                builderTeam[c] = 0
            }
            
            for starter in starters {
                for x in champsClass[starter.name]! /* the champs's classes + origins */ {
                    builderTeam[x]! += 1
                    if builderTeam[x]! > highest.1 {
                        highest = (x, builderTeam[x]!)
                    }
                }
            }
//            print(builderTeam)
            // TODO: remove duplicate classes
            
            // TODO: Find the next fasts builds you can add.
            let classKeyString = highest.0
            var slotsTillBonus = classesNeeded[classKeyString]! - highest.1
            
            // using most popular class, find the next champ.
            let nextOptions = champClassAssignement[highest.0.lowercased()]
            
            print("Remaining", classKeyString, ":", classesNeeded[classKeyString]! - highest.1)
            
            var count = 0
            while count < slotsTillBonus {
                var found = false
                for teammate in team {
                    if teammate.name == nextOptions![count].name {
                        found = true
                    }
                }
                if found == false {
                    print("Next teammate: ", nextOptions![count])
                    team.append(nextOptions![count])
                    slots -= 1
                    
                } else {
                    slotsTillBonus += 1

                }
                count += 1
            }
            // TODO: Handle if 5 champs (teamClassNeeded doesn't have [5])
            if slots == 5 {
                slots += 1
            }
            let lastSlots = teamClassNeeded[slots]![0]
            
            
            print(lastSlots)
//            print(champClassAssignement["void"])
            
            let lastChampOptions = champClassAssignement[lastSlots.lowercased()]!
            
            var counter = 0
            
            while counter < slots {
                var found = false
                for teammate in team {
                    if teammate.name == nextOptions![counter].name {
                        found = true
                    }
                }
                if found == false {
                    print("Next teammate: ", nextOptions![counter])
                    team.append(nextOptions![counter])
                    slots -= 1
                    
                } else {
                    slots += 1
                    
                }
                counter += 1
            }
            print("Team:", team.count)
            
            for teammate in team {
                print(teammate.name)
            }
            
//            for _ in 0...slotsTillBonus {
//
//
//                for champ in nextOptions! {
//                    print(champ.name)
//                }
//            }
            
//            print(teamClasses)
//            print(teamClassNeeded)
        }
    }

    
}
