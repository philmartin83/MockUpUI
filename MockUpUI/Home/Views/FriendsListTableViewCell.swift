//
//  FriendsListTableViewCell.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class FriendsListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
  
    

    var collectionView: UICollectionView = {
        
        //Flow layout
        let flowLayout = UICollectionViewFlowLayout()
        
        // edit properties here
        flowLayout.itemSize = CGSize(width: 120, height: 194)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        
        // handle collectionView
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Friends"
        title.font = UIFont.boldSystemFont(ofSize: 45)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    override func layoutSubviews() {
    
        self.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        
        self.addSubview(collectionView)
       
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -35).isActive = true
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "FriendsCollectionCell")
        collectionView.showsHorizontalScrollIndicator = false // dont watn to show the scoll indicator here.
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- CollectionView DataSource & Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsCollectionCell", for: indexPath)
        cell.contentView.backgroundColor = .white
        cell.styleUICollectionViewCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: 240, height: 240)
        return size
    }

}
