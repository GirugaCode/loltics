//
//  ItemBuilderView.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/24/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class ItemBuilderView: UIViewController {
    
    var items: [BuildsFrom]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let networklayer = NetworkLayer()
//        networklayer.getItems { (itemsData) in
//            print(itemsData)
////            self.items = itemsData
//        }

        // Do any additional setup after loading the view.
        view.backgroundColor = .clear
    }
    
    func loadItems() {
        TFTServices.shared.getItems { (itemGetResult) in
            switch itemGetResult {
            case let .success(itemData):
                self.items = itemData
                print(itemData)
            case let .failure(error):
                print(error)
            }
            DispatchQueue.main.async {
                //self.shopifyCollectionView.reloadData()
                print("Hello")
            }
        }
    }
}
