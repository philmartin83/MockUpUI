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
        flowLayout.itemSize = CGSize(width: 120, height: 185)
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
        title.font = UIFont.boldSystemFont(ofSize: boldFontSize)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.sizeToFit()
        return title
    }()
    
    var friendCount: UILabel = {
        let friendCount = UILabel()
        friendCount.font = UIFont.systemFont(ofSize: 16)
        friendCount.textColor = UIColor.colourStringWitHex(hexColour: "bfbfbf", withAlpha: 1)
        friendCount.translatesAutoresizingMaskIntoConstraints = false
        return friendCount
    }()
    
    var friends: [Friend] = {
        // normally this sort of stuff will be from the server in some json but for this demo purpose I'll create the array here may build some JSON to read from the bundle
        var newFriends = [Friend]()
        let arrayOfNames = ["Cheetara", "Lion-O", "Snarf", "Tygra", "WilyKit", "Pumyra", "Jaga", "Alluro"]
        for i in 0 ..< arrayOfNames.count{
            let img = UIImage(named: "Img\(i)")
            var friend = Friend(icon: img, name: arrayOfNames[i])
            newFriends.append(friend)
        }
        
        return newFriends
    }()
    
    var findFriendsButton: UIButton = {
        let findFirends = UIButton(type: .custom)
        findFirends.setTitle("Find Friends", for: .normal)
        findFirends.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        findFirends.titleLabel?.sizeToFit()
        findFirends.translatesAutoresizingMaskIntoConstraints = false
        findFirends.setTitleColor(.blue, for: .normal)
        return findFirends
    }()
    
    var viewAllFriendsButton: UIButton = {
        
        let seeAllFriends = UIButton(type: .custom)
        seeAllFriends.setTitle("See All Friends", for: .normal)
        seeAllFriends.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        seeAllFriends.titleLabel?.sizeToFit()
        seeAllFriends.translatesAutoresizingMaskIntoConstraints = false
        seeAllFriends.setTitleColor(.black, for: .normal)
        seeAllFriends.backgroundColor = secondaryButtonBackgroundColour
        seeAllFriends.layer.cornerRadius = buttonCornerRadius
        return seeAllFriends
    }()
    
    
    override func layoutSubviews() {
        // Add our title label
        self.contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.contentView.addSubview(findFriendsButton)
        findFriendsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        findFriendsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        // Add out friend count label
        self.contentView.addSubview(friendCount)
        friendCount.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        friendCount.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        friendCount.widthAnchor.constraint(equalToConstant: 120).isActive = true
        // we could do a check here to check for 1 friend of friends
        friendCount.text = "\(friends.count) Friends"
        
        // Add Collection View to hold friends
        self.contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView.topAnchor.constraint(equalTo: friendCount.bottomAnchor, constant: 25).isActive = true
        collectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: "FriendsCollectionCell")
        collectionView.showsHorizontalScrollIndicator = false // dont watn to show the scoll indicator here.
        
        self.contentView.addSubview(viewAllFriendsButton)
        viewAllFriendsButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        viewAllFriendsButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        viewAllFriendsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        viewAllFriendsButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
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
        return friends.count - 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsCollectionCell", for: indexPath) as! FriendCollectionViewCell
        let friend = friends[indexPath.row]
        if let proPic = friend.icon{
            cell.profileImage.image = proPic
        }else{
           cell.profileImage.image = #imageLiteral(resourceName: "Default")
        }
        cell.friendName.text = friend.name
        cell.contentView.backgroundColor = .white
        cell.styleUICollectionViewCell()
        return cell
    }

}
