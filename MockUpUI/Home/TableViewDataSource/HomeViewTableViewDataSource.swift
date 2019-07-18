//
//  HomeViewTableViewDataSource.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class HomeViewTableViewDataSource: NSObject, UITableViewDataSource {
    
    weak var controller: ViewController?
    fileprivate var feedArray: [Feed]?
    var reloadClosure: (()->Void)?
    
    func fetchData() {
        feedArray = DataLoader().loadDataFromBundle()
        reloadClosure?()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1{
            return 1
        }else{
            if let feedArray = feedArray{
                return feedArray.count
            }
            return 0
           
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let profileSectionCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileTableViewCell
            profileSectionCell.styleUITableViewCell()
            profileSectionCell.name.text = "Panthro"
            let bioString = UserDefaults.standard.string(forKey: bioTextKey)
            if let bio = bioString, bio.isEmpty{
                // check if our bio string is empty then add placeholder text
                profileSectionCell.bio.text = "Add a short bio to tell people more about yourself"
            }else{
                // if its not empty add the text
                profileSectionCell.bio.text = bioString
            }
            
            tableView.separatorStyle = .none
            profileSectionCell.addBioButton.addTarget(controller?.interactor, action: #selector(controller?.interactor.presentBioScreen), for: .touchUpInside)
            profileSectionCell.addStoryBtn.addTarget(controller?.interactor, action: #selector(controller?.interactor.loadFullCamera), for: .touchUpInside)
            profileSectionCell.profileSettingsButton.addTarget(controller?.interactor, action: #selector(controller?.interactor.settings), for: .touchUpInside)
            
            return profileSectionCell // we can force unwrap here as have already init'd above.
            
        }else if indexPath.section == 1{
            
            let friendsCell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell") as! FriendsListTableViewCell
            tableView.separatorStyle = .none
            friendsCell.viewAllFriendsButton.addTarget(controller?.interactor, action: #selector(controller?.interactor.loadAllFriends), for: .touchUpInside)
            friendsCell.styleUITableViewCell()
            return friendsCell
        }else{
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsFeed") as! NewsFeedTableViewCell
            let feedItem = feedArray?[indexPath.row]
            tableViewCell.feedTitle.text = feedItem?.title
            tableViewCell.feedImage.image = UIImage().base64Decode(strBase64: feedItem?.image)
            tableView.separatorStyle = .none
            return tableViewCell
        }
        
    }
}
