//
//  UIViewExtension.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundUpperCorners(radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func supportDarkMode(){
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            self.backgroundColor = .white
        }
    }
    
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
