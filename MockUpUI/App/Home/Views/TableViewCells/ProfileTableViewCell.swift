//
//  ProfileTableViewCell.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell, TableViewCellProtocol {
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
        let colour = secondaryButtonTextColour
        bioBtn.setTitleColor(colour!, for: .normal)
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
        let settingsIcon = UIImage(named: "Settings")?.withRenderingMode(.alwaysTemplate)
        settingsBtn.setImage(settingsIcon, for: .normal)
        settingsBtn.tintColor = secondaryButtonTextColour 
        settingsBtn.backgroundColor = secondaryButtonBackgroundColour
        settingsBtn.translatesAutoresizingMaskIntoConstraints = false
        settingsBtn.layer.cornerRadius = buttonCornerRadius
        return settingsBtn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImage)
        contentView.addSubview(name)
        contentView.addSubview(bio)
        contentView.addSubview(addBioButton)
        contentView.addSubview(addStoryBtn)
        contentView.addSubview(profileSettingsButton)
        layoutTableViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTableViewCell()
    }
    
    func layoutTableViewCell(){
        profileImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 240).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 240).isActive = true
        profileImage.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 15).isActive = true
        profileImage.image = #imageLiteral(resourceName: "Profile")
        
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 15).isActive = true

        bio.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        bio.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        bio.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true

        addBioButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        addBioButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        addBioButton.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 15).isActive = true
        addBioButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addStoryBtn.leadingAnchor.constraint(equalTo: addBioButton.leadingAnchor).isActive = true
        addStoryBtn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        addStoryBtn.topAnchor.constraint(equalTo: addBioButton.bottomAnchor, constant: 15).isActive = true
        addStoryBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true

        profileSettingsButton.leftAnchor.constraint(equalTo: addStoryBtn.rightAnchor, constant: 15).isActive = true
        profileSettingsButton.trailingAnchor.constraint(equalTo: addBioButton.trailingAnchor).isActive = true
        profileSettingsButton.topAnchor.constraint(equalTo: addStoryBtn.topAnchor).isActive = true
        profileSettingsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileSettingsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
}
