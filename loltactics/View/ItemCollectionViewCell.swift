//
//  ItemCollectionViewCell.swift
//  loltactics
//
//  Created by Ryan Nguyen on 10/7/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    //MARK: PROPERTIES
    static var identifier: String = "ItemCollectionCell"
    
    //MARK: UI COMPONENTS
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.cornerRadius = 4
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var itemImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "sparringgloves")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup UI
    func setupCell() {
        contentView.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        container.addSubview(self.itemImageView)
        NSLayoutConstraint.activate([
            itemImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            itemImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        ])
    }
}
