//
//  BioInteractor.swift
//  MockUpUI
//
//  Created by Phil Martin on 09/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class BioInteractor{
    
    weak var controller: BioViewController?
    
    @objc func popviewController(){
        controller?.navController?.popViewController(animated: true)
    }
    
    @objc func saveBio (sender: UIButton){
        // Animate the button press
        sender.animateButtonPress()
        // maybe add the bio to database, real world app would send to server
        UserDefaults.standard.set(controller?.presenter.bioTextView.text, forKey: bioTextKey)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let weakSelf = self{
                weakSelf.popviewController()
            }
        }
    }
}
