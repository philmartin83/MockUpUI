//
//  NewsFeedDataSource.swift
//  MockUpUI
//
//  Created by Philip Martin on 15/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import Foundation

class NewsFeedDataSource {
    
    var updateUIWithNewsFeedData: ((Feed?)-> Void)?
    
    func fetchNewsFeedItemById(id: Int?){
        let result = DataLoader().loadDataFromBundle()
        // get our data from the json in the bundle
        // unwrap the data and passed in item id and trigger the closure when the data is ready
        if let feed = result, let item = id{
            updateUIWithNewsFeedData?(feed[item])
        }else{
            // pass back nil and present an Alert
            updateUIWithNewsFeedData?(nil)
        }
    }
}

