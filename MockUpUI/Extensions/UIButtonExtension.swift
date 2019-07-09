//
//  UIButtonExtension.swift
//  EncryptionTest
//
//  Created by Phil Martin on 05/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit


extension UIButton {
    
    func animateButtonPress(){
        UIView.animate(withDuration: 0.2,
           animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
           completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        })
    }
}
