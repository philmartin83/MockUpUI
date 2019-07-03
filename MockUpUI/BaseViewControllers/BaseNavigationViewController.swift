//
//  BaseNavigationViewController.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    var barColour: UIColor?

    var leftTitle: String?

    
    var leftTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        navigationBar.barTintColor = barColour
    }
    
    override open var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
