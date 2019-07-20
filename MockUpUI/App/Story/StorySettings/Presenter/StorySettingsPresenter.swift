//
//  StorySettingsPresenter.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class StorySettingsPresenter: UIView, LayoutProtocol, NavigationBarProtocol {
    
    weak var controller: StorySettingsViewController?
    
    func setupNavBar(){
        
        controller?.navController = controller?.navigationController as? BaseNavigationViewController
        controller?.navController?.navigationBar.shadowImage = UIImage()
        
        if let navController = controller?.navController {
            navController.navigationBar.barTintColor = secondaryButtonBackgroundColour
        }
        
        guard let label = controller?.navController?.leftTitleLabel else {return}
        guard let button = controller?.navController?.closeButton else {return}
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        let closeBtn = UIBarButtonItem(customView: button)
        button.addTarget(controller?.interactor, action: #selector(controller?.interactor.closeSettings), for: .touchUpInside)
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        fixedSpace.width = 10.0
        let titleLabel = UIBarButtonItem(customView: label)
        
        controller?.navigationItem.leftBarButtonItems = [closeBtn, fixedSpace, titleLabel]
        controller?.navController?.leftTitleLabel.textColor = .black
        controller?.navController?.leftTitleLabel.text = "Story Settings"
    }
    
    func displayLayout() {
        
    }
}
