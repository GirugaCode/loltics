//
//  TeamBuilderView.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/24/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class TeamBuilderView: UIViewController {
    
    /// TOP LABEL
    var teamLabel: UITextView = {
        var title = UITextView()
        title.text = "Team"
        title.font = UIFont(name: "AvenirNext-Bold", size: UIScreen.main.bounds.height / 28) // Size to make it scalable (supposed to be around 33 onn iphone x)
        title.textColor = #colorLiteral(red: 0.176453799, green: 0.1764799953, blue: 0.1764449179, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .left
        title.isEditable = false
        title.isScrollEnabled = false
        title.isSelectable = false
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    /// FULL TEAM COMP COLLECTION VIEW
    var collectionView: UICollectionView!
    var flowLayout = UICollectionViewFlowLayout()
    
    // Couting cells for Flow layout
    var cellsMade = 0
    
    // Counting Cells for Cell rendering
    var madeFirstLine = 0
    
    /// COLLECTION VIEW BACKGROUND
    var collectionViewBackground: UIView = {
        var view = UIView()
        view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        
        view.backgroundColor = #colorLiteral(red: 0.9607108235, green: 0.9608257413, blue: 0.9606716037, alpha: 1)
        setupLayout()
    }
    
    func setupLayout() {
        setupCollectionView()
        view.addSubview(teamLabel)
        NSLayoutConstraint.activate([
            teamLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            teamLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
        
    }
    
    func setupCollectionView() {
        // Collection View Setup
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 120, width: view.bounds.width, height: view.bounds.width / 2), collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = false
        collectionView.register(ChampionCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        collectionView.contentOffset = .zero
        view.addSubview(collectionView)
    }
}

extension TeamBuilderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            print("first")
            return 5
        } else if section == 1 {
            print("second")

            return 5
        }
        else {
            print("third")

            return 4
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ChampionCollectionViewCell
        if indexPath.row == 0 && madeFirstLine == 1 {
            print("working")
            madeFirstLine += 1
            cell.champBorder.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
        else if indexPath.row == 4 && madeFirstLine == 0 {
            madeFirstLine += 1
        }
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell Pressed")
    }
}



extension TeamBuilderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if  cellsMade == 5 {
            print("diffenretn")
            cellsMade = 6
            return CGSize(width: view.bounds.size.width / 10, height: view.bounds.size.width / 5)
        }

        if cellsMade >= 10 {
            print("last cell")
            return CGSize(width: view.bounds.size.width / 4, height: view.bounds.size.width / 10)
        }
        cellsMade += 1
        return CGSize(width: view.bounds.size.width / 5, height: view.bounds.size.width / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        print("called")
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: view.bounds.size.width / -20, right: 0)
            
        }
        if section == 2 {
            return UIEdgeInsets(top: view.bounds.size.width / 40, left: 0, bottom: 0, right: 0)

        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Vertical Spacing
        if section == 0 {
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // Middle spacing
        if section == 0 {
            return 0
        }
        return 0
    }
    
}
