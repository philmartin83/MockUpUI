//
//  BaseNavigationViewController.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    lazy var leftTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImageView(image: UIImage(named: "BackButton")?.withRenderingMode(.alwaysTemplate))
        image.tintColor = .white
        backButton.setImage(image.image, for: .normal)
        
        return backButton
    }()
    
    lazy var closeButton: UIButton = {
        let closeBtn = UIButton(type: .custom)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.setImage(UIImage(named: "Close"), for: .normal)
        return closeBtn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.isTranslucent = false
        interactivePopGestureRecognizer?.delegate = nil;
    }
    
    override open var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
