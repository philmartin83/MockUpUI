//
//  UITableViewCellExtension.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

extension UITableViewCell{
    func styleUITableViewCell(){
        
        self.contentView.supportDarkMode()
        self.contentView.layer.cornerRadius = tableViewCellCornerRadius
        self.selectionStyle = .none
        self.contentView.clipsToBounds = true
        self.backgroundColor = .clear
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.23
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = shawdowColour?.cgColor
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
