//
//  NewsFeedInteractor.swift
//  MockUpUI
//
//  Created by Phil Martin on 15/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import Foundation

class NewsFeedInteractor{
    
    weak var controller: NewsFeedViewController?
    
    @objc func popviewController(){
        controller?.navController?.popViewController(animated: true)
    }
    
}
