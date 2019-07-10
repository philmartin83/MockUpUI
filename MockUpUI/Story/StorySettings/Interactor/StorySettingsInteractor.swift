//
//  StorySettingsInteractor.swift
//  MockUpUI
//
//  Created by Philip Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class StorySettingsInteractor{
    
    weak var controller: StorySettingsViewController?
    
    @objc func closeSettings(){
        controller?.dismiss(animated: true, completion: nil)
    }
    
}
