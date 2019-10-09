//
//  ChampionCollectionViewCell.swift
//  loltactics
//
//  Created by timofey makhlay on 9/26/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class ChampionCollectionViewCell: UICollectionViewCell {
    
    var champBorder: UIView = {
        var view = UIView()
        view.layer.borderWidth = 2
//        view.layer.shadowOpacity = 0.7
//        view.layer.shadowRadius = 5
//        view.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        view.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = UIScreen.main.bounds.width / 27.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var champImage: UIImageView = {
        var newImage = UIImageView()
        newImage.image = UIImage()
        newImage.translatesAutoresizingMaskIntoConstraints = false
        return newImage
    }()
    
//    // Continue Button image
//    var champImage: UIImageView = {
//        var newImage = UIImageView()
//        newImage.image = #imageLiteral(resourceName: "Aatrox-Icon")
//        newImage.translatesAutoresizingMaskIntoConstraints = false
//        return newImage
//    }()
//    
//
//    // Addting title to Navbar
//    let viewNavbarTitle: UITextView = {
//        var title = UITextView()
//        title.text = "Categories"
//        title.font = UIFont(name: "AvenirNext-Medium", size: 60)
//        title.textColor = #colorLiteral(red: 0.1075617597, green: 0.09771008044, blue: 0.1697227657, alpha: 1)
//        title.backgroundColor = nil
//        title.textAlignment = .center
//        title.isEditable = false
//        title.isScrollEnabled = false
//        title.isSelectable = false
//        return title
//    }()
//
//    // Constant to set font size relative for device.
//    let relativeFontConstant:CGFloat = 0.05
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        viewNavbarTitle.font = viewNavbarTitle.font!.withSize(UIScreen.main.bounds.height * relativeFontConstant)
//
//        addSubview(navbar)
//        addSubview(viewNavbarTitle)
        
        
//        navbar.snp.makeConstraints { (make) in
//            make.left.right.top.equalTo(self)
//            make.height.equalTo(self.bounds.height)
//        }
        //        navbar.alpha = 1
        //        navbar.backgroundColor = #colorLiteral(red: 0.4823529412, green: 0.9333333333, blue: 0.8117647059, alpha: 1)
        
//        viewNavbarTitle.snp.makeConstraints { (make) in
//            make.left.equalTo(safeAreaLayoutGuide).offset(15)
//            make.centerY.equalTo(navbar)
//        }
        setupCellLayout()
    }
    
    func setupCellLayout() {
        self.addSubview(champBorder)
//        self.ad dSubview(champImage)
        NSLayoutConstraint.activate([
            champBorder.topAnchor.constraint(equalTo: self.topAnchor),
            champBorder.leftAnchor.constraint(equalTo: self.leftAnchor),
            champBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            champBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
//        champImage.frame = champBorder.bounds
//        champImage.mask = champBorder
//

        self.addSubview(champImage)
        NSLayoutConstraint.activate([
            champImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            champImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            champImage.heightAnchor.constraint(equalToConstant: 50),
            champImage.widthAnchor.constraint(equalToConstant: 50)
            //
            //            champImage
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
