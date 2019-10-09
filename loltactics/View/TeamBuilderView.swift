//
//  TeamBuilderView.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/24/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class TeamBuilderView: UIViewController {
    let teamBuilder = TeamBuilder()
    
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
    
    // Output array pretty much
    var championsRecommended: [ChampionData] = []
    
    // Couting cells for Flow layout
    var cellsMade = 0
    
    // Counting Cells for Cell rendering
    var madeFirstLine = 0
    var madeSecondLine = 0
    
    var numberOfCells = 0
    
    // Scaling whole collection view
    var collectionViewScale = UIScreen.main.bounds.width * 0.8
    
    // teamClasses
    var classesLabel: UITextView = {
        var title = UITextView()
        title.text = "Classes"
        title.font = UIFont(name: "AvenirNext-Bold", size: UIScreen.main.bounds.height / 40) // Size to make it scalable (supposed to be around 33 onn iphone x)
        title.textColor = #colorLiteral(red: 0.176453799, green: 0.1764799953, blue: 0.1764449179, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .left
        title.isEditable = false
        title.isScrollEnabled = false
        title.isSelectable = false
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
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
    
    
//    let searchController = UISearchController(searchResultsController: nil)
    
//    var filteredChampions = [ChampionData]()
    
    // TABLE VIEW
    // Cell ID
    private let cellId = "tableCell"
    
    // Creating table view
    var tableView = UITableView()
    
    // ALL CHAMPS
    var allChampsDict: newChampion = [:]
    var allChampsArray: [ChampionData] = []

    // CHAMP SELECTS
    var selectionsBackground: UIView = {
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
    
    var selectionsStack = UIStackView()
    
    var selectionOne = false
    var selectionTwo = false
    var selectionThree = false
    
    var championsSelected: [String] = []
    
    // Images for selected champs
    var champSelectOne: UIButton = {
        var button = UIButton()
        button.setTitle("1", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        button.addTarget(self, action: #selector(removeChampOne), for: .touchUpInside)
        return button
    }()
    
    var champSelectTwo: UIButton = {
        var button = UIButton()
        button.setTitle("2", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.addTarget(self, action: #selector(removeChampTwo), for: .touchUpInside)
        return button
    }()
    
    var champSelectThree: UIButton = {
        var button = UIButton()
        button.setTitle("3", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.addTarget(self, action: #selector(removeChampThree), for: .touchUpInside)
        return button
    }()
    
    var first: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.4937598109, green: 0.3993486464, blue: 0.9166263342, alpha: 1)
        view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = UIScreen.main.bounds.width / 27.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var second: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.4937598109, green: 0.3993486464, blue: 0.9166263342, alpha: 1)
        view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = UIScreen.main.bounds.width / 27.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var third: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.4937598109, green: 0.3993486464, blue: 0.9166263342, alpha: 1)
        view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = UIScreen.main.bounds.width / 27.6
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
        setupTableView()
        setupChampSelections()
        makeTabBackground()
        downloadAllChamps()
        
        // MARK: UNCOMMENT HERE TO HAVE DATA
//        teamBuilder.buildModel()
//        teamBuilder.buildClassDict()
//        teamBuilder.countChamps()
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
        
        view.addSubview(classesLabel)
        NSLayoutConstraint.activate([
            classesLabel.bottomAnchor.constraint(equalTo: champSelectBackground.topAnchor),
            classesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            classesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            classesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
//
//        // Search tab background
//        view.addSubview(searchBackground)
//        NSLayoutConstraint.activate([
//            searchBackground.topAnchor.constraint(equalTo: champSelectBackground.topAnchor, constant: 25),
//            searchBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            searchBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
//            searchBackground.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.14)
//            ])
        
//        view.addSubview(searchBar)
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        searchBar.trailingAnchor.constraint(equalTo: searchBackground.trailingAnchor).isActive = true
//        searchBar.heightAnchor.constraint(equalTo: searchBackground.heightAnchor).isActive = true
//        searchBar.leadingAnchor.constraint(equalTo: searchBackground.leadingAnchor, constant: 0).isActive = true
//        searchBar.topAnchor.constraint(equalTo: searchBackground.topAnchor, constant: 0).isActive = true
////        selectionsStack.centerYAnchor.constraint(equalTo: selectionsBackground.centerYAnchor).isActive = true
//
//
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
        tableView = UITableView(frame: CGRect(x: 15, y: collectionViewScale, width: view.bounds.size.width - 30, height: (view.bounds.size.height - ((collectionViewScale) + (view.bounds.size.height/8)))))
        
        // MARK: This is gonna be useful when I'm returning the searchbar.
        
//        searchController.searchResultsUpdater = self
////        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search Champions"
//        //        navigationItem.searchController = searchController
////        definesPresentationContext = true
//
////        searchController.searchResultsUpdater = self
//        //        searchController.hidesNavigationBarDuringPresentation = false
//        //        searchController.dimsBackgroundDuringPresentation = false
//        //        searchController.searchBar.sizeToFit()
//        tableView.tableHeaderView = searchController.searchBar
//
        // Add to Table View to View
        view.addSubview(tableView)

        
        // Register Table View Cells
        tableView.register(ChampionTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Table View
        tableView.backgroundColor = .clear
//        view.bringSubviewToFront(tableView)
        


        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        

    }
    
    func setupChampSelections() {
        // SELECTIONS
        view.addSubview(selectionsBackground)
        NSLayoutConstraint.activate([
            selectionsBackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            selectionsBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.size.width/3.5),
            selectionsBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (view.bounds.size.width/3.5) * -1),
            selectionsBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (view.bounds.size.height/7) * -1),
            selectionsBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])
        view.bringSubviewToFront(selectionsBackground)
        
        selectionsStack = UIStackView(arrangedSubviews: [champSelectOne,champSelectTwo,champSelectThree])
        selectionsStack.axis = .horizontal
        selectionsStack.alignment = .center
        selectionsStack.distribution = .fillEqually
        
        view.addSubview(selectionsStack)
//        print("x:\(view.bounds.width / 2), y: \(view.bounds.height * 0.06)")
//        selectionsStack.frame = CGRect(x: view.bounds.width / 2, y: view.bounds.height * 0.06, width: 100, height: 50)
        
        selectionsStack.translatesAutoresizingMaskIntoConstraints = false
        selectionsStack.widthAnchor.constraint(equalToConstant: 142).isActive = true
        selectionsStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        selectionsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 117).isActive = true
//        selectionsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        selectionsStack.centerYAnchor.constraint(equalTo: selectionsBackground.centerYAnchor).isActive = true

        
        view.bringSubviewToFront(selectionsStack)
        selectionsStack.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//        NSLayoutConstraint.activate([
//            selectionsStack.topAnchor.constraint(equalTo: selectionsBackground.topAnchor),
//            selectionsStack.leadingAnchor.constraint(equalTo: selectionsBackground.leadingAnchor),
//            selectionsStack.trailingAnchor.constraint(equalTo: selectionsBackground.trailingAnchor),
//            selectionsStack.bottomAnchor.constraint(equalTo: selectionsBackground.bottomAnchor),
//            selectionsStack.centerXAnchor.constraint(equalTo: selectionsBackground.centerXAnchor)
//            ])
    }
    
    @objc func removeChampOne() {
        if championsSelected.count > 0 {
            championsRecommended.remove(at: 0)
            championsSelected.remove(at: 0)
            
            
            collectionView.reloadData()
            updateClassLabel()
            
            if championsSelected.count == 0 {
                selectionOne = false
                selectionTwo = false
                selectionThree = false
                
                champSelectOne.setImage(UIImage(), for: .normal)
                champSelectTwo.setImage(UIImage(), for: .normal)
                champSelectThree.setImage(UIImage(), for: .normal)
            } else if championsSelected.count == 1 {
                selectionOne = true
                selectionTwo = false
                selectionThree = false
                
                champSelectOne.setImage(UIImage(named:(championsSelected[0] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(), for: .normal)
                champSelectThree.setImage(UIImage(), for: .normal)
            } else if championsSelected.count == 2 {
                selectionOne = true
                selectionTwo = true
                selectionThree = false
                
                champSelectOne.setImage(UIImage(named:(championsSelected[0] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(named:(championsSelected[1] + "-Icon")), for: .normal)
                champSelectThree.setImage(UIImage(), for: .normal)
            } else if championsSelected.count == 3 {
                selectionOne = true
                selectionTwo = true
                selectionThree = true
                
                champSelectOne.setImage(UIImage(named:(championsSelected[0] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(named:(championsSelected[1] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(named:(championsSelected[2] + "-Icon")), for: .normal)
            }
        }
    }
    
    @objc func removeChampTwo() {
        if championsSelected.count > 1 {
            championsRecommended.remove(at: 1)
            championsSelected.remove(at: 1)
            
            
            collectionView.reloadData()
            updateClassLabel()

            if championsSelected.count == 1 {
                selectionOne = true
                selectionTwo = false
                selectionThree = false
                
                champSelectOne.setImage(UIImage(named:(championsSelected[0] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(), for: .normal)
                champSelectThree.setImage(UIImage(), for: .normal)
            } else if championsSelected.count == 2 {
                selectionOne = true
                selectionTwo = true
                selectionThree = false
                
                champSelectOne.setImage(UIImage(named:(championsSelected[0] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(named:(championsSelected[1] + "-Icon")), for: .normal)
                champSelectThree.setImage(UIImage(), for: .normal)
            } else if championsSelected.count == 3 {
                selectionOne = true
                selectionTwo = true
                selectionThree = true
                
                champSelectOne.setImage(UIImage(named:(championsSelected[0] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(named:(championsSelected[1] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(named:(championsSelected[2] + "-Icon")), for: .normal)
            }
        }
    }
    
    @objc func removeChampThree() {
        if championsSelected.count == 3 {
            championsRecommended.remove(at: 2)
            championsSelected.remove(at: 2)
            
            
            collectionView.reloadData()
            updateClassLabel()
            
            if championsSelected.count == 2 {
                selectionOne = true
                selectionTwo = true
                selectionThree = false
                
                champSelectOne.setImage(UIImage(named:(championsSelected[0] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(named:(championsSelected[1] + "-Icon")), for: .normal)
                champSelectThree.setImage(UIImage(), for: .normal)
            } else if championsSelected.count == 3 {
                selectionOne = true
                selectionTwo = true
                selectionThree = true
                
                champSelectOne.setImage(UIImage(named:(championsSelected[0] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(named:(championsSelected[1] + "-Icon")), for: .normal)
                champSelectTwo.setImage(UIImage(named:(championsSelected[2] + "-Icon")), for: .normal)
            }
        }
    }
    
    func updateClassLabel() {
//        championClass
        var origins: [String] = []
        for champClass in championsRecommended {
            for origin in champClass.origin {
                if origins.contains(origin) == false {
                    origins.append(origin)
                }
            }
            
            for classData in champClass.championClass {
                if origins.contains(classData) == false {
                    origins.append(classData)
                }
            }
        }
        classesLabel.text = origins.joined(separator: ", ")
    }
    
    
    
    
    
    
    
    /// GET REQUEST to https://solomid-resources.s3.amazonaws.com/blitz/tft/data/champions.json for champs JSON
    func downloadAllChamps() {
        let url = URL(string: "https://solomid-resources.s3.amazonaws.com/blitz/tft/data/champions.json")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
//            print(String(data: data, encoding: .utf8)!)
            do {
                let myStruct = try JSONDecoder().decode(newChampion.self, from: data)
//                print(myStruct)
                DispatchQueue.main.async {
                    self.allChampsDict = myStruct
                    
                    let sortedKeys = self.allChampsDict.keys.sorted(by: >)
                    
                    for key in sortedKeys {
                        if let obj = self.allChampsDict[key] {
                            self.allChampsArray.insert(obj, at: 0)
                        }
                    }
//                    print("All champs array count", self.allChampsArray.count)
                    self.tableView.reloadData()
//
//                    for count in 0...2 {
//                        self.championsRecommended.append(self.allChampsArray[count])
//                    }
//                    // MARK: Might need to delete.
//                    self.collectionView.reloadData()
                }
            } catch {
                print("Didn't work")
                return
            }
            
        }
        
        task.resume()
//        numberOfCells = 0
    }
    
    // MARK: For searchbar in table view
//    func isFiltering() -> Bool {
//        return searchController.isActive && !searchBarIsEmpty()
//    }
}

extension TeamBuilderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            print("first")
//            return 5
//        } else /* if section == 1 */ {
//            print("second")
//            return 5
//        }
//        else {
//            print("third")
//            return 4
//        }
        return championsRecommended.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ChampionCollectionViewCell
        if championsRecommended.count > 0 {
            cell.champImage.image = UIImage(named: (championsRecommended[indexPath.row].name + "-Icon"))
        }
        
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell tapped")
    }
}



extension TeamBuilderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewScale / 5, height: collectionViewScale / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        print("called")
//        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//        }
//        if section == 2 {
//            return UIEdgeInsets(top: collectionViewScale / 40, left: 0, bottom: 0, right: 0)
//
//        }
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
//        if isFiltering() {
//            return filteredChampions.count
//        }
        return allChampsArray.count
    }
    
    // Table View Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create Cells one by one using this as a blueprint.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChampionTableViewCell
        var champ: ChampionData
//        if isFiltering() {
//            champ = filteredChampions[indexPath.row]
//        } else {
        champ = allChampsArray[indexPath.row]
//        }
        
        cell.champName.text = champ.name
//        print((allChampsArray[indexPath.row].name + "-Icon.png"))
        cell.champImage.image = UIImage(named: (champ.name + "-Icon"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Tapped")
        
        var canContinue = true
        
        // Check if champ already selected
        for string in championsSelected {
            if allChampsArray[indexPath.row].name == string {
                canContinue = false
            }
        }
        if canContinue == true {
            if selectionOne == false {
                selectionOne = true
                championsSelected.append(allChampsArray[indexPath.row].name)
                champSelectOne.setImage(UIImage(named: (allChampsArray[indexPath.row].name + "-Icon")), for: .normal)
                championsRecommended.append(allChampsArray[indexPath.row])
                collectionView.reloadData()
                updateClassLabel()
            } else if selectionTwo == false {
                selectionTwo = true
                championsSelected.append(allChampsArray[indexPath.row].name)
                champSelectTwo.setImage(UIImage(named: (allChampsArray[indexPath.row].name + "-Icon")), for: .normal)
                championsRecommended.append(allChampsArray[indexPath.row])
                collectionView.reloadData()
                updateClassLabel()
            }
            else if selectionThree == false {
                selectionThree = true
                championsSelected.append(allChampsArray[indexPath.row].name)
                champSelectThree.setImage(UIImage(named: (allChampsArray[indexPath.row].name + "-Icon")), for: .normal)
                championsRecommended.append(allChampsArray[indexPath.row])
                collectionView.reloadData()
                updateClassLabel()
            } else {
                print("full")
            }
        }
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

//extension String {
//    func toImage() -> UIImage? {
//        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
//            return UIImage(data: data)
//        }
//        print("Image not found")
//        return nil
//    }
//}
//
//extension TeamBuilderView: UISearchResultsUpdating {
//    // MARK: - UISearchResultsUpdating Delegate
//    func updateSearchResults(for searchController: UISearchController) {
//        // TODO
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//
//    func searchBarIsEmpty() -> Bool {
//        // Returns true if the text is empty or nil
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        filteredChampions = allChampsArray.filter({( champ : ChampionData) -> Bool in
//            return champ.name.lowercased().contains(searchText.lowercased())
//        })
//
//        tableView.reloadData()
//    }
//}
