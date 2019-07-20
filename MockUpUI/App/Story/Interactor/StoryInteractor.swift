//
//  StoryInteractor.swift
//  MockUpUI
//
//  Created by Philip Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class StoryInteractor{
    weak var controller: StoryViewController?
    
    var updateFlashState: (()-> Void)?
    
    @objc func backToHome(sender: UIButton){
        sender.animateButtonPress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let weakSelf = self{
                let transition = CATransition()
                transition.duration = duration
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                weakSelf.controller?.view.window!.layer.add(transition, forKey: kCATransition)
                weakSelf.controller?.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @objc func displayStorySettings(sender: UIButton){
        sender.animateButtonPress()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let weakSelf = self{
                let settings = StorySettingsViewController()
                let navi = BaseNavigationViewController(rootViewController: settings)
                navi.modalPresentationStyle = .currentContext
                weakSelf.controller?.present(navi, animated: true, completion: nil)
            }
        }
    }
    
    @objc func flashState(sender: UIButton){
        sender.animateButtonPress()
        updateFlashState?()
    }
    
    @objc func shutterButtonTapper(sender: UIButton){
        sender.animateButtonPress()
        // add a weakSelf to stop any potential retain cycles
        // probably going to move this completion ?!?!?!?!
        controller?.presenter.cameraController.captureImage(completion: {  (image, error) in
            print(image as Any)
        })
    }

}
