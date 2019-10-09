//
//  ItemTableViewCell.swift
//  loltactics
//
//  Created by Ryan Nguyen on 10/8/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    //MARK: PROPERTIES
    static var identifier: String = "ItemTableCell"
    
    //MARK: UI COMPONENTS
    var itemBoarder: UIView = {
        var view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = UIScreen.main.bounds.width / 27.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var itemName: UILabel = {
        var label = UILabel()
        label.text = "Spatula"
        label.font = UIFont(name: "AvenirNext-Bold", size: UIScreen.main.bounds.height / 28) // Size to make it scalable (supposed to be around 33 onn iphone x)
        label.textColor = #colorLiteral(red: 0.176453799, green: 0.1764799953, blue: 0.1764449179, alpha: 1)
        label.backgroundColor = nil
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var itemImage: UIImageView = {
        var image = UIImageView()
        image.image = #imageLiteral(resourceName: "spatula")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
     }
     
     // Required with initilizer
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    func setupCellLayout() {
        addSubview(itemBoarder)

        NSLayoutConstraint.activate([
            itemBoarder.topAnchor.constraint(equalTo: self.topAnchor),
            itemBoarder.leftAnchor.constraint(equalTo: self.leftAnchor),
            itemBoarder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            itemBoarder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        addSubview(itemName)
        NSLayoutConstraint.activate([
            itemName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemName.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        addSubview(itemImage)
        NSLayoutConstraint.activate([
            itemImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            itemImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: 50),
            itemImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

}
