//
//  MainViewInteractor.swift
//  MockUpUI
//
//  Created by Phil Martin on 09/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class MainViewInteractor{
    
    weak var viewController: ViewController?
    
    @objc func presentBioScreen(sender: UIButton){
        sender.animateButtonPress()
        let bio = BioViewController()
        if let controller = viewController?.navController{
          controller.pushViewController(bio, animated: true)
        }
    }
}
