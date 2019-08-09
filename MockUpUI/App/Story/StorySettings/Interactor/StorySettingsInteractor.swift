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
    var updateUI: ((UIButton) ->Void)?
    
    @objc func closeSettings(){
        controller?.dismiss(animated: true, completion: nil)
    }
    
    @objc func togglePrivacyState(sender: UIButton){
        sender.isSelected = !sender.isSelected
        updateUI?(sender)
    }
}
