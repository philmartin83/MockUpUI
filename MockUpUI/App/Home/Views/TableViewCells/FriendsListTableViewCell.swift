//
//  FriendsListTableViewCell.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

final class FriendsListTableViewCell: UITableViewCell, TableViewCellProtocol , UICollectionViewDelegate {
    
    var dataSource = HomeCollectionViewDataSource()

    lazy var collectionView: UICollectionView = {
        
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
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Friends"
        title.font = UIFont.boldSystemFont(ofSize: boldFontSize)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.sizeToFit()
        return title
    }()
    
    lazy var friendCount: UILabel = {
        let friendCount = UILabel()
        friendCount.font = UIFont.systemFont(ofSize: 16)
        friendCount.textColor = UIColor.colourStringWitHex(hexColour: "bfbfbf", withAlpha: 1)
        friendCount.translatesAutoresizingMaskIntoConstraints = false
        return friendCount
    }()
    
    lazy var friends: [Friend] = {
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
    
    lazy var findFriendsButton: UIButton = {
        let findFirends = UIButton(type: .custom)
        findFirends.setTitle("Find Friends", for: .normal)
        findFirends.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        findFirends.titleLabel?.sizeToFit()
        findFirends.translatesAutoresizingMaskIntoConstraints = false
        findFirends.setTitleColor(.blue, for: .normal)
        return findFirends
    }()
    
    lazy var viewAllFriendsButton: UIButton = {
        
        let seeAllFriends = UIButton(type: .custom)
        seeAllFriends.setTitle("See All Friends", for: .normal)
        let seeAllFriendsTitleColour = defaultTextColour
        seeAllFriends.setTitleColor(seeAllFriendsTitleColour, for: .normal)
        seeAllFriends.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        seeAllFriends.titleLabel?.sizeToFit()
        seeAllFriends.translatesAutoresizingMaskIntoConstraints = false
        seeAllFriends.backgroundColor = secondaryButtonBackgroundColour
        seeAllFriends.layer.cornerRadius = buttonCornerRadius
        return seeAllFriends
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.clipsToBounds = true
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(findFriendsButton)
        // Add out friend count label
        self.contentView.addSubview(friendCount)
        // Add Collection View to hold friends
        self.contentView.addSubview(collectionView)
        
        self.contentView.addSubview(viewAllFriendsButton)
        layoutTableViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        // Add our title label
        super.layoutSubviews()
        layoutTableViewCell()
    }
    
    func layoutTableViewCell() {

        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    
        findFriendsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        findFriendsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    
        friendCount.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        friendCount.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        friendCount.widthAnchor.constraint(equalToConstant: 120).isActive = true
        // we could do a check here to check for 1 friend of friends
        friendCount.text = "\(friends.count) Friends"
        
        // set our friends of the data source
        dataSource.friends = friends
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView.topAnchor.constraint(equalTo: friendCount.bottomAnchor, constant: 25).isActive = true
        collectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: "FriendsCollectionCell")
        collectionView.showsHorizontalScrollIndicator = false // dont want to show the scoll indicator here.

        viewAllFriendsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        viewAllFriendsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        viewAllFriendsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        viewAllFriendsButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        viewAllFriendsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK:- CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // TODO: Cell selection push to nav stack and prese info about friend
        let cell = dataSource.collectionView(collectionView, cellForItemAt: indexPath)
        cell.animateButtonPress() // animate our cell press
    }
}
