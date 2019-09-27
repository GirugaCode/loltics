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
    var madeSecondLine = 0
    
    var numberOfCells = 0
    
    // Scaling whole collection view
    var collectionViewScale = UIScreen.main.bounds.width * 0.8
    
    /// COLLECTION VIEW BACKGROUND
    var champSelectBackground: UIView = {
        var view = UIView()
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.26).cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0.0, height: -4.0)
        view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = UIScreen.main.bounds.width / 27.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var searchBackground: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.4937598109, green: 0.3993486464, blue: 0.9166263342, alpha: 1)
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.26).cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = UIScreen.main.bounds.width / 27.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // TABLE VIEW
    // Cell ID
    private let cellId = "tableCell"
    
    // Creating table view
    var tableView = UITableView()
    

    
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
        setupTableView()
        makeTabBackground()

    }
    
    func setupLayout() {
        
        // TOP
        setupCollectionView()
        view.addSubview(teamLabel)
        NSLayoutConstraint.activate([
            teamLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            teamLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
        
    // SEARCH
        
        // Background
        view.addSubview(champSelectBackground)
        NSLayoutConstraint.activate([
            champSelectBackground.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -30),
            champSelectBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            champSelectBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            champSelectBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        
        // Search tab background
        view.addSubview(searchBackground)
        NSLayoutConstraint.activate([
            searchBackground.topAnchor.constraint(equalTo: champSelectBackground.topAnchor, constant: 25),
            searchBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchBackground.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.14)
            ])
        
    }
    
    func setupCollectionView() {
        // Collection View Setup
        collectionView = UICollectionView(frame: CGRect(x: (view.bounds.size.width - collectionViewScale) / 2, y: 120, width: collectionViewScale, height: view.bounds.width / 2), collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = false
        collectionView.register(ChampionCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear // #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        collectionView.contentOffset = .zero
        view.addSubview(collectionView)
    }
    
    fileprivate func makeTabBackground() {
        let mainTabBackground: UIView = {
            let view = UIView()
            view.layer.shadowOpacity = 1
            view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.26).cgColor
            view.layer.shadowRadius = 4
            view.layer.shadowOffset = CGSize(width: 0.0, height: -4.0)
            view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            view.layer.cornerRadius = UIScreen.main.bounds.width / 27.6
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        // TAB BACKGROUND
        view.addSubview(mainTabBackground)
        NSLayoutConstraint.activate([
            mainTabBackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.125),
            mainTabBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainTabBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainTabBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            mainTabBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])
        
        view.bringSubviewToFront(mainTabBackground)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: collectionViewScale + collectionViewScale / 5, width: view.bounds.size.width, height: (view.bounds.size.height - ((collectionViewScale + collectionViewScale / 5) + (view.bounds.size.height/8)))))
        // Add to Table View to View
        view.addSubview(tableView)

        
        // Register Table View Cells
        tableView.register(ChampionTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Table View
        tableView.backgroundColor = .red
//        view.bringSubviewToFront(tableView)
        


        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
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
        print(numberOfCells)
        if numberOfCells >= 10 {
            print("second line working")
            madeFirstLine += 1
            cell.champBorder.backgroundColor = #colorLiteral(red: 0.176453799, green: 0.1764799953, blue: 0.1764449179, alpha: 1)
            cell.champBorder.layer.borderWidth = 0
        }
        
        else if numberOfCells == 5 {
            print("working")
            madeFirstLine += 1
            madeSecondLine += 1
            cell.champBorder.backgroundColor = .clear
            cell.champBorder.layer.borderWidth = 0
        }
//        else if numberOfCells == 4 {
//            madeFirstLine += 1
//        }
        numberOfCells += 1
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
            return CGSize(width: collectionViewScale / 10, height: collectionViewScale / 5)
        }

        if cellsMade >= 10 {
            print("last cell")
            return CGSize(width: collectionViewScale / 4, height: collectionViewScale / 10)
        }
        cellsMade += 1
        return CGSize(width: collectionViewScale / 5, height: collectionViewScale / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        print("called")
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: collectionViewScale / -20, right: 0)
            
        }
        if section == 2 {
            return UIEdgeInsets(top: collectionViewScale / 40, left: 0, bottom: 0, right: 0)

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


extension TeamBuilderView: UITableViewDataSource {
    // Table View Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // Table View Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Cells one by one using this as a blueprint.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChampionTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
    }
}

extension TeamBuilderView: UITableViewDelegate {
    //     Table View Cell Styling
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Deselected")
    }
}
