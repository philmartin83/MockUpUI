//
//  ProfileTableViewCell.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    var profileImage: UIImageView = {
        let imV = UIImageView()
        imV.layer.cornerRadius = 240 / 2 // create our rounded profilePic
        imV.contentMode = .scaleAspectFill
        imV.backgroundColor = .blue
        imV.clipsToBounds = true
        imV.translatesAutoresizingMaskIntoConstraints = false
        return imV
    }()
    
    var name: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    var bio: UILabel = {
        let bio = UILabel()
        bio.font = UIFont.systemFont(ofSize: 16)
        bio.numberOfLines = 0
        bio.textAlignment = .center
        bio.textColor = .lightGray
        bio.translatesAutoresizingMaskIntoConstraints = false
        return bio
    }()
    
    var addBioButton: UIButton = {
        var bioBtn = UIButton(type: .custom)
        bioBtn.setTitle("+ Add Bio", for: .normal)
        bioBtn.setTitleColor(.black, for: .normal)
        bioBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        bioBtn.backgroundColor = secondaryButtonBackgroundColour
        bioBtn.translatesAutoresizingMaskIntoConstraints = false
        bioBtn.layer.cornerRadius = buttonCornerRadius
        return bioBtn
    }()
    
    var addStoryBtn: UIButton = {
        var storyBtn = UIButton(type: .custom)
        storyBtn.backgroundColor = primaryColour
        storyBtn.setTitleColor(.white, for: .normal)
        storyBtn.imageView?.contentMode = .scaleAspectFit
        let btnIcon = UIImage(named: "Camera")?.withRenderingMode(.alwaysTemplate)
        storyBtn.setImage(btnIcon, for: .normal)
        storyBtn.setTitle("Add Story", for: .normal)
        storyBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        storyBtn.imageView?.tintColor = .white
        storyBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        storyBtn.imageView?.tintColor = .white
        storyBtn.layer.cornerRadius = buttonCornerRadius
        storyBtn.translatesAutoresizingMaskIntoConstraints = false
        return storyBtn
        
    }()
    
    var profileSettingsButton: UIButton = {
        let settingsBtn = UIButton(type: .custom)
        settingsBtn.setImage(#imageLiteral(resourceName: "Settings"), for: .normal)
        settingsBtn.backgroundColor = secondaryButtonBackgroundColour
        settingsBtn.translatesAutoresizingMaskIntoConstraints = false
        settingsBtn.layer.cornerRadius = buttonCornerRadius
        return settingsBtn
    }()
    
    override func layoutSubviews() {
        self.contentView.clipsToBounds = true
        self.contentView.addSubview(profileImage)
        profileImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 240).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 240).isActive = true
        profileImage.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 15).isActive = true
        profileImage.image = #imageLiteral(resourceName: "Profile")
        
        self.contentView.addSubview(name)
        name.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 15).isActive = true
        
        self.contentView.addSubview(bio)
        bio.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        bio.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        bio.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
        
        self.contentView.addSubview(addBioButton)
        addBioButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        addBioButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        addBioButton.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 15).isActive = true
        addBioButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.contentView.addSubview(addStoryBtn)
        addStoryBtn.leadingAnchor.constraint(equalTo: addBioButton.leadingAnchor).isActive = true
        addStoryBtn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        addStoryBtn.topAnchor.constraint(equalTo: addBioButton.bottomAnchor, constant: 15).isActive = true
        addStoryBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.contentView.addSubview(profileSettingsButton)
        profileSettingsButton.leftAnchor.constraint(equalTo: addStoryBtn.rightAnchor, constant: 15).isActive = true
        profileSettingsButton.trailingAnchor.constraint(equalTo: addBioButton.trailingAnchor).isActive = true
        profileSettingsButton.topAnchor.constraint(equalTo: addStoryBtn.topAnchor).isActive = true
        profileSettingsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    }
}
