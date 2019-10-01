//
//  ChampionTableViewCell.swift
//  loltactics
//
//  Created by timofey makhlay on 9/26/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class ChampionTableViewCell: UITableViewCell {
 
    var champBorder: UIView = {
        var view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = UIScreen.main.bounds.width / 27.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    /// TOP LABEL
//    var champName: UITextView = {
//        var title = UITextView()
//        title.text = "Team"
//        title.font = UIFont(name: "AvenirNext-Bold", size: UIScreen.main.bounds.height / 28) // Size to make it scalable (supposed to be around 33 onn iphone x)
//        title.textColor = #colorLiteral(red: 0.176453799, green: 0.1764799953, blue: 0.1764449179, alpha: 1)
//        title.backgroundColor = nil
//        title.textAlignment = .left
//        title.isEditable = false
//        title.isScrollEnabled = false
//        title.isSelectable = false
//        title.translatesAutoresizingMaskIntoConstraints = false
//        return title
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        setupCellLayout()
    }
    
    // Required with initilizer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCellLayout() {
        self.addSubview(champBorder)
        NSLayoutConstraint.activate([
            champBorder.topAnchor.constraint(equalTo: self.topAnchor),
            champBorder.leftAnchor.constraint(equalTo: self.leftAnchor),
            champBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            champBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            
//            champName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            champName.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
}

