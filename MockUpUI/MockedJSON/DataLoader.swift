//
//  DataLoader.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import Foundation

class DataLoader  {
    
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
    
}
