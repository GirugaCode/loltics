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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
     }
     
     // Required with initilizer
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

}
