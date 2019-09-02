//
//  HomeCollectionViewDataSource.swift
//  MockUpUI
//
//  Created by Philip Martin on 16/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

final class HomeCollectionViewDataSource: NSObject, UICollectionViewDataSource{
    
    var friends: [Friend]?

    //MARK:- CollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let friends = friends else {return 0}
        return friends.count - 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsCollectionCell", for: indexPath) as! FriendCollectionViewCell
        let friend = friends?[indexPath.row]
        if let proPic = friend?.icon{
            cell.profileImage.image = proPic
        }else{
            cell.profileImage.image = #imageLiteral(resourceName: "Default")
        }
        cell.friendName.text = friend?.name
        cell.contentView.backgroundColor = .white
        cell.styleUICollectionViewCell()
        return cell
    }
}
