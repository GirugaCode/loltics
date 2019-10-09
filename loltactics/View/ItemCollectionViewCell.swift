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
    static var identifier: String = "ItemCell"
    
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
    
    var colorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
            container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        container.addSubview(self.colorView)
        NSLayoutConstraint.activate([
            colorView.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: self.container.centerYAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 20),
            colorView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
