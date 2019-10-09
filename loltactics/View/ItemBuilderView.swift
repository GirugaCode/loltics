//
//  ItemBuilderView.swift
//  loltactics
//
//  Created by Ryan Nguyen on 9/24/19.
//  Copyright © 2019 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class ItemBuilderView: UIViewController, ItemViewModelDelegate {
    
    
    //MARK: PROPERTIES
    var baseItems = ["recurvebow", "giantsbelt", "needlesslylargerod", "chainvest", "sparringgloves", "negatroncloak","bfsword","tearofthegoddess","spatula"]
    var selectedItems = [String]()
    var viewModel = ItemViewModel()
    
    
    //MARK: UI COMPONENTS
    var itemBuilderLabel: UILabel = {
        var title = UILabel()
        title.text = "Item Builder"
        title.font = UIFont(name: "AvenirNext-Bold", size: UIScreen.main.bounds.height / 28)
        title.textColor = #colorLiteral(red: 0.176453799, green: 0.1764799953, blue: 0.1764449179, alpha: 1)
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var itemCreationBackground: UIView = {
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
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadItems()
        
        setupCollectionView()
        setupTableView()
        setupUI()
    }
    
    //MARK: SETUP UI
    func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
    }
    
    func setupTableView() {
        // Add to Table View to View
        itemCreationBackground.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: itemCreationBackground.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: itemCreationBackground.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: itemCreationBackground.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: itemCreationBackground.bottomAnchor)
        ])
        
        // Register Table View Cells
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)

    }
    
    func setupUI() {
        view.addSubview(itemBuilderLabel)
        NSLayoutConstraint.activate([
            itemBuilderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            itemBuilderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
        
        view.addSubview(itemCreationBackground)
        NSLayoutConstraint.activate([
            itemCreationBackground.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -480),
            itemCreationBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            itemCreationBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            itemCreationBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    
    //MARK: DELEGATE CALL
    func itemCallFinished() {
        collectionView.reloadData()
    }
}


//MARK: Delegates and Datasource
extension ItemBuilderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return baseItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        cell.itemImageView.image = UIImage(named: baseItems[indexPath.row])
        return cell
    }
}

extension ItemBuilderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped Cell \(indexPath.row)")
    }
}

extension ItemBuilderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width / 5, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 110, left: 50, bottom: 50, right: 50) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension ItemBuilderView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        return cell
    }
}

extension ItemBuilderView: UITableViewDelegate {
    
    //Table View Cell Styling
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Deselected")
    }
    
}
