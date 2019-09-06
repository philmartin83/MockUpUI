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
        
        if #available(iOS 13.0, *) {
            self.contentView.backgroundColor = .systemBackground
        } else {
           // Fallback on earlier versions
            self.contentView.backgroundColor = .white
        }
        self.contentView.layer.cornerRadius = tableViewCellCornerRadius
        self.selectionStyle = .none
        self.contentView.clipsToBounds = true
        self.backgroundColor = .clear
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.23
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = shawdowColour?.cgColor
    }
}
