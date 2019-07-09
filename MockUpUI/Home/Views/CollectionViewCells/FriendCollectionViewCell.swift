//
//  FriendCollectionViewCell.swift
//  MockUpUI
//
//  Created by Phil Martin on 04/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    var profileImage: UIImageView = {
        let imageV = UIImageView()
        imageV.layer.cornerRadius = 100 / 2
        imageV.clipsToBounds = true
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    var friendName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.font = UIFont.boldSystemFont(ofSize: 15)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textAlignment = .center
        return name
    }()
    
    override func layoutSubviews() {
        self.addSubview(profileImage)
        profileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.addSubview(friendName)
        friendName.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        friendName.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        friendName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
    }
}
