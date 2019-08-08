//
//  StorySettingsPresenter.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class StorySettingsPresenter: UIView, LayoutProtocol, NavigationBarProtocol {
    
    weak var controller: StorySettingsViewController?
    var scroller: UIScrollView = {
        let tbView = UIScrollView()
        tbView.translatesAutoresizingMaskIntoConstraints = false
        return tbView
    }()
    
    var saveRow: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var savePhotosTitle: UILabel = {
        let label = UILabel()
        label.text = "Save shared photos"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var savePhotosBody: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Automatically save photos and videos to your phone when you share them"
        return label
    }()
    
    var savePhotoSwitch: UISwitch = {
        let toggle = UISwitch(frame: .zero)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    var savePhotosIcon: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .blue
        return img
    }()
    
    var privacyDescTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Who can see your story?"
        return label
    }()
    
    var privacyDescBody: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Your story will be visible for 24 hours on this app. This setting doesn't apply to live videos that you share to your story."
        return label
    }()
    
    
    func setupNavBar(){
        
        controller?.navController = controller?.navigationController as? BaseNavigationViewController
        controller?.navController?.navigationBar.shadowImage = UIImage()
        
        if let navController = controller?.navController {
            navController.navigationBar.barTintColor = secondaryButtonBackgroundColour
        }
        
        guard let label = controller?.navController?.leftTitleLabel else {return}
        guard let button = controller?.navController?.closeButton else {return}
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        let closeBtn = UIBarButtonItem(customView: button)
        button.addTarget(controller?.interactor, action: #selector(controller?.interactor.closeSettings), for: .touchUpInside)
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        fixedSpace.width = 10.0
        let titleLabel = UIBarButtonItem(customView: label)
        
        controller?.navigationItem.leftBarButtonItems = [closeBtn, fixedSpace, titleLabel]
        controller?.navController?.leftTitleLabel.textColor = .black
        controller?.navController?.leftTitleLabel.text = "Story Settings"
    }
    
    func displayLayout() {
        guard let controller = controller else {return}
        controller.view.addSubview(scroller)
        scroller.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        scroller.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        scroller.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        scroller.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        
        scroller.addSubview(saveRow)
        saveRow.leadingAnchor.constraint(equalTo: scroller.leadingAnchor).isActive = true
        saveRow.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        saveRow.topAnchor.constraint(equalTo: scroller.topAnchor, constant: 20).isActive = true
        
        saveRow.addSubview(savePhotosIcon)
        savePhotosIcon.leadingAnchor.constraint(equalTo: saveRow.leadingAnchor, constant: 10).isActive = true
        savePhotosIcon.centerYAnchor.constraint(equalTo: saveRow.centerYAnchor).isActive = true
        savePhotosIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        savePhotosIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        saveRow.addSubview(savePhotosTitle)
        savePhotosTitle.leadingAnchor.constraint(equalTo: savePhotosIcon.trailingAnchor, constant: 10).isActive = true
        savePhotosTitle.trailingAnchor.constraint(equalTo: saveRow.trailingAnchor, constant: -10).isActive = true
        savePhotosTitle.topAnchor.constraint(equalTo: saveRow.topAnchor, constant: 5).isActive = true
        
        saveRow.addSubview(savePhotoSwitch)
        saveRow.addSubview(savePhotosBody)
        savePhotoSwitch.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -10).isActive = true
        savePhotoSwitch.topAnchor.constraint(equalTo: savePhotosBody.topAnchor).isActive = true
        
      
        savePhotosBody.leadingAnchor.constraint(equalTo: savePhotosTitle.leadingAnchor).isActive = true
        savePhotosBody.trailingAnchor.constraint(equalTo: savePhotoSwitch.leadingAnchor, constant: -30).isActive = true
        savePhotosBody.topAnchor.constraint(equalTo: savePhotosTitle.bottomAnchor, constant: 5).isActive = true
        
        saveRow.bottomAnchor.constraint(equalTo: savePhotosBody.bottomAnchor, constant: 10).isActive = true
        
        scroller.addSubview(privacyDescTitle)
        privacyDescTitle.leadingAnchor.constraint(equalTo: savePhotosIcon.leadingAnchor).isActive = true
        privacyDescTitle.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -40).isActive = true
        privacyDescTitle.topAnchor.constraint(equalTo: saveRow.bottomAnchor, constant: 80).isActive = true
        
        scroller.addSubview(privacyDescBody)
        privacyDescBody.leadingAnchor.constraint(equalTo: savePhotosIcon.leadingAnchor).isActive = true
        privacyDescBody.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -40).isActive = true
        privacyDescBody.topAnchor.constraint(equalTo: privacyDescTitle.bottomAnchor, constant: 10).isActive = true
    }
    
}
