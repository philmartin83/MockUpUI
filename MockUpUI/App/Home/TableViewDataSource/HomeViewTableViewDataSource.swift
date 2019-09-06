//
//  HomeViewTableViewDataSource.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

final class HomeViewTableViewDataSource: NSObject, UITableViewDataSource {
    
    fileprivate var feedArray: [Feed]?
    var reloadClosure: (()->Void)?
    var presentBioClosure: ((UIButton) -> Void)?
    var loadFullCameraClosure: ((UIButton) -> Void)?
    var presentSettingsClosure: ((UIButton) -> Void)?
    
    var loadAllFriendsClosure: ((UIButton) -> Void)?
    
    func fetchData() {
        feedArray = DataLoader().loadDataFromBundle()
        reloadClosure?()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1{
            return 1
        }else{
            guard let feedArray = feedArray else {return 0}
            return feedArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let profileSectionCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileTableViewCell
            profileSectionCell.styleUITableViewCell()
            profileSectionCell.name.text = "Panthro"
            let bioString = UserDefaults.standard.string(forKey: bioTextKey)
            if let bio = bioString{
                // if its not nil add the text
                profileSectionCell.bio.text = bio
            }else{
                // check if our bio string is nil and add default place holder text.
                profileSectionCell.bio.text = defualtBioTextForHomeScreen
            }
            
            tableView.separatorStyle = .none
            profileSectionCell.addBioButton.addTarget(self, action: #selector(presentBioScreen), for: .touchUpInside)
            profileSectionCell.addStoryBtn.addTarget(self, action: #selector(loadFullCamera), for: .touchUpInside)
            profileSectionCell.profileSettingsButton.addTarget(self, action: #selector(presentSettings), for: .touchUpInside)
            
            return profileSectionCell // we can force unwrap here as have already init'd above.
            
        }else if indexPath.section == 1{
            
            let friendsCell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell") as! FriendsListTableViewCell
            tableView.separatorStyle = .none
            friendsCell.viewAllFriendsButton.addTarget(self, action: #selector(loadAllFriends), for: .touchUpInside)
            friendsCell.styleUITableViewCell()
            return friendsCell
        }else{
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsFeed") as! NewsFeedTableViewCell
            tableViewCell.setCellData(data: feedArray?[indexPath.row])
            tableView.separatorStyle = .none
            return tableViewCell
        }
        
    }
    
    //MARK:- Responders
    
    @objc private func presentBioScreen(sender: UIButton){
        presentBioClosure?(sender)
    }
    
    @objc private func loadFullCamera(sender: UIButton){
        loadFullCameraClosure?(sender)
    }
    
    @objc private func presentSettings(sender: UIButton){
        presentSettingsClosure?(sender)
    }
    
    @objc private func loadAllFriends(sender: UIButton){
        loadAllFriendsClosure?(sender)
    }
}  
