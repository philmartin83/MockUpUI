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
}
