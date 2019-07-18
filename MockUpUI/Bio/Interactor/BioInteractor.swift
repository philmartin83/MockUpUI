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
        sender.animateButtonPress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            // TODO add some code here but for now we will dismiss
            // May be add a DB to store the bio or use userdefault?!?!?!?!
            if let weakSelf = self{
                weakSelf.popviewController()
            }
        }
    }
}
