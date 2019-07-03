//
//  UICollectionViewCellExtension.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

extension UICollectionViewCell{
    func styleUICollectionViewCell(){
        self.contentView.layer.cornerRadius = 20
        self.contentView.clipsToBounds = true
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.23
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
