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
    var dummyItems = ["bfsword", "bloodthirster", "guardian angel", "zekes herald", "deathblade", "giant slayer","dsa","dsadsa","dsadsa"]
    var data: [Int] = Array(0..<9)
    var items: Item = [:]
    var allItems: [ItemValue] = []
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadItems()
        
        setupCollectionView()
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
    
    func setupUI() {
        self.view.addSubview(itemBuilderLabel)
        NSLayoutConstraint.activate([
            itemBuilderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            itemBuilderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
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
        return dummyItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        let data = dummyItems[indexPath.item]
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
