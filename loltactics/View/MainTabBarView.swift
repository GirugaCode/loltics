//
//  MainTabBarView.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/24/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class MainTabBarView: UITabBarController {
    
    var tabBarView: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        view.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.opacity = 0
        view.layer.cornerRadius = UIScreen.main.bounds.width / 27.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let itemBuilderView = ItemBuilderView()
    let teamBuilderView = TeamBuilderView()
    let devAboutView = DevAboutView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupConstraints()
        setupTabBarViews()
    }
    
    
    fileprivate func setupTabBarViews() {
        itemBuilderView.tabBarItem.image = #imageLiteral(resourceName: "Item-Icon")
        itemBuilderView.tabBarItem.selectedImage = #imageLiteral(resourceName: "Item-Icon-Active")
        
        teamBuilderView.tabBarItem.image = #imageLiteral(resourceName: "Team-item")
        teamBuilderView.tabBarItem.selectedImage = #imageLiteral(resourceName: "Team-item-Active")
        
        devAboutView.tabBarItem.image = #imageLiteral(resourceName: "About-icon")
        devAboutView.tabBarItem.selectedImage = #imageLiteral(resourceName: "About-icon-Active")
        
        tabBar.tintColor = #colorLiteral(red: 0.4509803922, green: 0.4352941176, blue: 0.8941176471, alpha: 1)
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        viewControllers = [itemBuilderView, teamBuilderView, devAboutView]
    }
    
//    fileprivate func setupConstraints() {
//
//        view.addSubview(tabBarView)
//
//        NSLayoutConstraint.activate([
//            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            //        tabBarView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2.5),
////            tabBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//
//            tabBarView.heightAnchor.constraint(equalToConstant: 200)
//        ])
//
//    }
    
}
