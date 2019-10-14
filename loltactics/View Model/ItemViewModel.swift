//
//  ItemViewModel.swift
//  loltactics
//
//  Created by Ryan Nguyen on 10/8/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

protocol ItemViewModelDelegate {
    func itemCallFinished()
}

class ItemViewModel: NSObject {
    
    //MARK: PROPERTIES
    var items: Item = [:]
    var allItems: [ItemValue] = []
    var delegate: ItemViewModelDelegate?
    
    //MARK: FUNCTIONS
    func loadItems() {
        TFTServices.shared.getItems { (itemGetResult) in
            switch itemGetResult {
            case let .success(itemData):
                self.items = itemData
                
                // Sorting through all the items in JSON
                let sortedKeys = itemData.keys.sorted(by: >)
                for key in sortedKeys {
                    if let obj = itemData[key] {

                        self.allItems.insert(obj, at: 0)
                    }
                }
            case let .failure(error):
                print(error)
            }
            DispatchQueue.main.async {
                self.delegate?.itemCallFinished()
            }
        }
    }
    
}
