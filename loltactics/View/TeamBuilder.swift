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
    
    // MARK: All DATA
    /// All the TFT Characters
    var champs: [ChampionData] = []
    
    /// All TFT Classes
    var classes: [ChampClass] = [] // JUST ONE ITEM (ALL THE CLASSES 🤣) TODO FIX
    
    /// How many of this class do you need to get the bonus
    var classesNeeded: [String: Int] = [:] // ['Assassin': 9, ... ]
    
    /// Depending on how many champs of the same type you have, what bonus you could get
    var teamClassNeeded: [Int: [String]] = [3: [], 6: [], 9: [], 2: [], 1: [], 4: []] // [3: ["Elementalist", "Pirate"], 2:...
    
    /// What champions are in each class
    var champClassAssignement: [String: [ChampionData]] = [:] // ['Yorlde': Veigar, ... ]
    
    /// What classes each champion is
    var champsClass: [String: [String]] = [:] // ['Aatrox' : ['Demon', 'BladeMaster'], 'Yasuo':['Exile','BladeMaster']...
    
    func printAllData() {
        
        // Check on Champion Objects
        print("/n/n-------- ALL CHAMPS -------")
        print("Champ Count: ", champs.count)
        
        // Print all chamo names
        for a in champs {
            print(a.name, champsClass[a.name]!) // Oct 18, 2019 count is 57
        }
        
        
        // Check on Classes
        print("/n/n-------- ALL CLASSES -------")
        print("Classes Count: ", classes.count) // Oct 18, 2019 count is 57
        
        // Print all chamo names
        for b in classes {
            print(b.name)
        }
        
        
        // Check custom data
        print("/n/n-------- ALL CUSTOM DATA -------")
        
        
        print("Number for Bonus:")
        for c in teamClassNeeded.keys {
            print(c, teamClassNeeded[c]!)
        }
        
        print("Champ count per class:")
        for key in champClassAssignement.keys {
            print("There\'s", champClassAssignement[key]!.count, "\(key)s")
        }
    }
    
    // MARK: All Champs
    func loadChamps() {
        TFTServices.shared.getChamps() { (champGetResult) in
            switch champGetResult {
                
            case let .success(champData):
                self.champs = champData
            case let .failure(error):
                print(error)

            }
            DispatchQueue.main.async {
                print("Number of champs:",self.champs.count, " == 57?") // prints the number of champs
                
                self.pullClasses() // Call to the next function

            }
        }
    }
    
    // MARK: Champion Classes
    func pullClasses() {
        TFTServices.shared.getChampsClass { (champClassGetResult) in
            switch champClassGetResult {
                
            case let .success(champClassData):
                
                // TODO: Get aroudn the array method without initilizers.
                self.classes = champClassData
                
            case let .failure(error):
                print(error)
                
            }
            DispatchQueue.main.async {
                self.pullOrigins() // Call to the next function
            }
        }
    }
    
    // MARK: Champion Origins
    func pullOrigins() {
        TFTServices.shared.getChampsOrigin { (champClassGetResult) in
            switch champClassGetResult {
                
            case let .success(champClassData):
                
                // TODO: Get aroudn the array method without initilizers.
                self.classes += champClassData

            case let .failure(error):
                print(error)
                
            }
            DispatchQueue.main.async {
                // TODO: Move this for after pulling origins and classes.
                NotificationCenter.default.post(name: Notification.Name("loadedChamps"), object: nil) // after havaing pulled classes / origins / championss
                
                self.fillClassNeededArray() // Call to the next function
            }
        }
    }
    
    // MARK: Make All Custom Data
    func fillClassNeededArray() {
        for champClass in classes {
            var highest = 0
            for bonus in champClass.bonuses {

                if highest < bonus.needed {
                    highest = bonus.needed

                }
            }
            teamClassNeeded[highest]!.append(champClass.name)
            classesNeeded[champClass.name] = highest
        }
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
        
        // MARK: FINISHED MAKING DATA
        printAllData()
        
//        print(champClassAssignement.keys.count, champClassAssignement)
//        for key in champClassAssignement.keys {
//            print(key, champClassAssignement[key]!.count)
//        }
        
//        print(champsClass)
        
//        buildATeam(starters: [champs[5], champs[7], champs[20]])
    }
    
    
    
//    func buildATeam(starters: [ChampionData]) {
//        var team: [ChampionData] = []
//
//        var teamClasses: [String] = []
//
//        var slots = 9
//
//        var builderTeam: [String:Int] = [:]
//
//        var highest: (String, Int) = ("Classname", 0)
//
//        if starters.count > 3 {
//            // TODO: Throw error if too many champs given
//            print("Too many")
//        } else {
//
//            // Adding the base Team
//            for starter in starters {
////                print(champsClass[starter.name])
//                team.append(starter) // Appending selected champ to the team
//                teamClasses += (champsClass[starter.name]!) // Adding the must have champion's classes
//
//                slots -= 1
//            }
//
//            for c in teamClasses {
//                builderTeam[c] = 0
//            }
//
//            for starter in starters {
//                for x in champsClass[starter.name]! /* the champs's classes + origins */ {
//                    builderTeam[x]! += 1
//                    if builderTeam[x]! > highest.1 {
//                        highest = (x, builderTeam[x]!)
//                    }
//                }
//            }
////            print(builderTeam)
//            // TODO: remove duplicate classes
//
//            // TODO: Find the next fasts builds you can add.
//            let classKeyString = highest.0
//            var slotsTillBonus = classesNeeded[classKeyString]! - highest.1
//
//            // using most popular class, find the next champ.
//            let nextOptions = champClassAssignement[highest.0.lowercased()]
//
//            print("Remaining", classKeyString, ":", classesNeeded[classKeyString]! - highest.1)
//
//            var count = 0
//            while count < slotsTillBonus {
//                var found = false
//                for teammate in team {
//                    if teammate.name == nextOptions![count].name {
//                        found = true
//                    }
//                }
//                if found == false {
//                    print("Next teammate: ", nextOptions![count])
//                    team.append(nextOptions![count])
//                    slots -= 1
//
//                } else {
//                    slotsTillBonus += 1
//
//                }
//                count += 1
//            }
//            // TODO: Handle if 5 champs (teamClassNeeded doesn't have [5])
//            if slots == 5 {
//                slots += 1
//            }
//            let lastSlots = teamClassNeeded[slots]![0]
//
//
//            print(lastSlots)
////            print(champClassAssignement["void"])
//
//            let lastChampOptions = champClassAssignement[lastSlots.lowercased()]!
//
//            var counter = 0
//
//            while counter < slots {
//                var found = false
//                for teammate in team {
//                    if teammate.name == nextOptions![counter].name {
//                        found = true
//                    }
//                }
//                if found == false {
//                    print("Next teammate: ", nextOptions![counter])
//                    team.append(nextOptions![counter])
//                    slots -= 1
//
//                } else {
//                    slots += 1
//
//                }
//                counter += 1
//            }
//            print("Team:", team.count)
//
//            for teammate in team {
//                print(teammate.name)
//            }
//
////            for _ in 0...slotsTillBonus {
////
////
////                for champ in nextOptions! {
////                    print(champ.name)
////                }
////            }
//
////            print(teamClasses)
////            print(teamClassNeeded)
//        }
//    }

    
}
