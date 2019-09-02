//
//  MainViewInteractor.swift
//  MockUpUI
//
//  Created by Phil Martin on 09/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

final class MainViewInteractor{
    
    weak var viewController: ViewController?
    
    @objc func presentBioScreen(sender: UIButton){
        sender.animateButtonPress()
        // add a small delay just so we can get the animation effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let weakSelf = self{
                let bio = BioViewController()
                if let controller = weakSelf.viewController?.navController{
                    controller.pushViewController(bio, animated: true)
                }
            }
        }
    }
    
    @objc func settings(sender: UIButton){
        sender.animateButtonPress()
    }
    
    @objc func loadFullCamera(sender: UIButton){
        sender.animateButtonPress()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let weakSelf = self{
                let story = StoryViewController()
//                let transition = CATransition()
//                transition.duration = duration
//                transition.type = CATransitionType.push
//                transition.subtype = CATransitionSubtype.fromLeft
//                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
//                weakSelf.viewController?.view.window!.layer.add(transition, forKey: kCATransition)
                weakSelf.viewController?.present(story, animated: true, completion: nil)
            }
        }
       
    }
    
    @objc func loadAllFriends(sender: UIButton){
        sender.animateButtonPress()
    }
}
