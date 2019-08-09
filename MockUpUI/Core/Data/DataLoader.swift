//
//  DataLoader.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class DataLoader  {
    
    //MARK:- News Feed Data
    func loadDataFromBundle() -> [Feed]?{
        if let filepath = Bundle.main.path(forResource: "demo", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: filepath)
                let jsonData = try Data(contentsOf: url)
                let feed = try JSONDecoder().decode([Feed].self, from: jsonData)
                return feed
            } catch {
                // contents could not be loaded
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    //MARK:- Settings Data
    func getDataForPrivacySettings() -> [PrivacySettings]{
        // could put this into a mocked json payload, which will save having to create these objects
        // and in place use decoable.
        let priv1 = PrivacySettings(title: "Public", icon: UIImage(named: "Public")?.withRenderingMode(.alwaysTemplate), subtitle: "Anyone on mySocial App", accessoryType: .checkbox, selected: false)
        let priv2 = PrivacySettings(title: "Friends and Connections", icon: UIImage(named: "FriendsConnections")?.withRenderingMode(.alwaysTemplate), subtitle: "Your mySocial App and their connections", accessoryType: .checkbox, selected: true)
        let priv3 = PrivacySettings(title: "Friends", icon: UIImage(named: "Friends")?.withRenderingMode(.alwaysTemplate), subtitle: "Only your mySocial friends", accessoryType: .checkbox, selected: false)
        let priv4 = PrivacySettings(title: "Custom", icon: UIImage(named: "CustomFriends")?.withRenderingMode(.alwaysTemplate), subtitle: "Chose people to show your story", accessoryType: .checkbox, selected: false)
        return [priv1, priv2, priv3, priv4]
    }
    
    func getDataForHiddenOrMutedStoeries() -> [PrivacySettings]{
        let priv1 = PrivacySettings(title: "Hide your story from", icon: UIImage(named: "Hide")?.withRenderingMode(.alwaysTemplate), subtitle:nil, accessoryType: .chevron, selected: false)
        let priv2 = PrivacySettings(title: "Stories you've muted", icon: UIImage(named: "MutedStory")?.withRenderingMode(.alwaysTemplate), subtitle: nil, accessoryType: .chevron, selected: false)
        return [priv1, priv2]
    }
    
}
