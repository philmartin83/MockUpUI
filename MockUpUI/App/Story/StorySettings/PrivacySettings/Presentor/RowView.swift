//
//  RowView.swift
//  MockUpUI
//
//  Created by Phil Martin on 08/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class RowView: UIView{
    
    //MARK:- Properties
    var iconView: UIImageView = {
        let imgV = UIImageView()
        // set out icon's tint colour
        imgV.tintColor = iconGrey
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()
    
    var titleView: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subtitleView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: bodyFontSize)
        label.numberOfLines = 0
        label.textColor = iconGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var accessoryViewSwitch: UISwitch = {
        let toggle = UISwitch(frame: .zero)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    var accesscoryViewChevron: UIImageView = {
        let imgV = UIImageView()
        // set out icon's tint colour
        imgV.tintColor = iconGrey
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()
    
    var accessoryViewCheckbox: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK:- Helper
    func setupRow(type: PrivacyAccessoryType? = PrivacyAccessoryType.none) {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(titleView)
        addSubview(subtitleView)
        
        titleView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10).isActive = true
        // check our accessory type and adjust accordingly
        if type == .chevron || type == PrivacyAccessoryType.none{
            titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }else{
            titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        }
        titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    
        if type == .toggle{
            addSubview(accessoryViewSwitch)
            accessoryViewSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            accessoryViewSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }else if type == .chevron{
            addSubview(accesscoryViewChevron)
            accesscoryViewChevron.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
            accesscoryViewChevron.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            accesscoryViewChevron.widthAnchor.constraint(equalToConstant: 20).isActive = true
            accesscoryViewChevron.heightAnchor.constraint(equalToConstant: 20).isActive = true
            accesscoryViewChevron.image = UIImage(named: "BackStory")?.withRenderingMode(.alwaysTemplate)
        }
        else if type == .checkbox{
            addSubview(accessoryViewCheckbox)
            accessoryViewCheckbox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
            accessoryViewCheckbox.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            accessoryViewCheckbox.widthAnchor.constraint(equalToConstant: 30).isActive = true
            accessoryViewCheckbox.heightAnchor.constraint(equalToConstant: 30).isActive = true
            accessoryViewCheckbox.setImage(UIImage(named: "EmptyCheckbox")?.withRenderingMode(.alwaysTemplate), for: .normal)
            accessoryViewCheckbox.setImage(UIImage(named: "CheckboxChecked")?.withRenderingMode(.alwaysTemplate), for: .selected)
        }
        
        
        subtitleView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor).isActive = true
        subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10).isActive = true
        subtitleView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -40).isActive = true
        bottomAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: 10).isActive = true

    }
}
