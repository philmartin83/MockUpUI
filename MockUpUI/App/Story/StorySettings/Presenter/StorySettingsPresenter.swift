//
//  StorySettingsPresenter.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class StorySettingsPresenter: UIView, LayoutProtocol, NavigationBarProtocol {
    
    //MARK:- Properties
    weak var controller: StorySettingsViewController?
    var datasource = DataLoader()
    var previousRow: UIView?
    var previouslySelectedPrivacyOption: UIButton?
    var collapsableRow: RowView?
    
    lazy var scroller: UIScrollView = {
        let tbView = UIScrollView()
        tbView.translatesAutoresizingMaskIntoConstraints = false
        return tbView
    }()

    lazy var privacyDescTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        label.text = "Who can see your story?"
        return label
    }()
    
    lazy var privacyDescBody: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: bodyFontSize)
        label.numberOfLines = 0
        label.text = "Your story will be visible for 24 hours on this app. This setting doesn't apply to live videos that you share to your story."
        return label
    }()
    
    lazy var disclaimerMessage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: bodyFontSize)
        label.numberOfLines = 0
        label.text = "Only your friends and connections can reply directly to your story"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK:- Protocol
    func displayLayout() {
        setupScrollView()
        handlePrivacyUpdate()
    }
    
    //MARK:- View Setuo
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
    
    func setupScrollView(){
        guard let controller = controller else {return}
        controller.view.addSubview(scroller)
        scroller.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        scroller.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        scroller.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        scroller.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        // only execute if the above passes
        setupSavePhotosListRow()
    }
    
    func setupSavePhotosListRow(){
        guard let controller = controller else {return}
        let row = RowView()
        scroller.addSubview(row)
        row.iconView.image = UIImage(named: "SavedPhoto")?.withRenderingMode(.alwaysTemplate)
        row.titleView.text = "Save shared photos"
        row.subtitleView.text = "Automatically save photos and videos to your phone when you share them"
        row.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        row.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        row.topAnchor.constraint(equalTo: scroller.topAnchor, constant: 10).isActive = true
        row.setupRow(type: .toggle)
        previousRow = row
        // only execute if the above passes
        setupPrivacyHeaderSection()
    }
    
    func setupPrivacyHeaderSection(){
        guard let controller = controller else {return}
        scroller.addSubview(privacyDescTitle)
        privacyDescTitle.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 10).isActive = true
        privacyDescTitle.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -40).isActive = true
        guard let newRow = previousRow else {return}
        privacyDescTitle.topAnchor.constraint(equalTo: newRow.bottomAnchor, constant: 70).isActive = true
        scroller.addSubview(privacyDescBody)
        privacyDescBody.leadingAnchor.constraint(equalTo: privacyDescTitle.leadingAnchor).isActive = true
        privacyDescBody.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -40).isActive = true
        privacyDescBody.topAnchor.constraint(equalTo: privacyDescTitle.bottomAnchor, constant: 10).isActive = true
        
        setupPrivacySectionList()
    }
    
    func setupPrivacySectionList(){
        var counter = 0
        guard let controller = controller else {return}
        datasource.getDataForPrivacySettings().forEach { (setting) in
            let row = RowView()
            scroller.addSubview(row)
            row.titleView.text = setting.title
            
            // handle the checkbox.
            if setting.accessoryType == .checkbox{
                row.accessoryViewCheckbox.isSelected = setting.selected
                if setting.selected{
                    row.accessoryViewCheckbox.tintColor = navbarColour
                    previouslySelectedPrivacyOption = row.accessoryViewCheckbox
                }else{
                    row.accessoryViewCheckbox.tintColor = iconGrey
                }
                row.accessoryViewCheckbox.tag = counter // add a tag for later
            }
            
            row.iconView.image = setting.icon?.withRenderingMode(.alwaysTemplate)
            row.subtitleView.text = setting.subtitle
            row.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
            row.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
            row.setupRow(type: setting.accessoryType)
            if counter == 0{
                row.topAnchor.constraint(equalTo: privacyDescBody.bottomAnchor, constant: 20).isActive = true
            }else{
                guard let newRow = previousRow else {return} // get the hell out. TO DO add an alertviewcontroller and clean the view "Cannot get data" or something like that
                row.topAnchor.constraint(equalTo: newRow.bottomAnchor).isActive = true
            }
            row.accessoryViewCheckbox.addTarget(controller.interactor, action: #selector(controller.interactor.togglePrivacyState), for: .touchUpInside)
            previousRow = row
            counter = counter+1
        }
        setupDisclaimerText()
        setupHideAndMuteStories()
    }
    /// Handle disclaimer messger which is normally hidden behind the hide story row.
    func setupDisclaimerText(){
        guard let controller = controller else {return}
        scroller.addSubview(disclaimerMessage)
        disclaimerMessage.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 10).isActive = true
        disclaimerMessage.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -10).isActive = true
        disclaimerMessage.alpha = 0.0
        guard let newRow = previousRow else {return} // get the hell out. TO DO add an alertviewcontroller and clean the view "Cannot get data" or something like that
        disclaimerMessage.topAnchor.constraint(equalTo: newRow.bottomAnchor, constant: 20).isActive = true
    }
    
    func setupHideAndMuteStories(){
        guard let controller = controller else {return}
        var counter = 0
        datasource.getDataForHiddenOrMutedStories().forEach { (setting) in
            let row = RowView()
            scroller.addSubview(row)
            if counter == 0{
                collapsableRow = row
            }
            row.titleView.text = setting.title
            row.iconView.image = setting.icon?.withRenderingMode(.alwaysTemplate)
            row.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
            row.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
            guard let newRow = previousRow else {return} // get the hell out. TO DO add an alertviewcontroller and clean the view "Cannot get data" or something like that
            row.topAnchor.constraint(equalTo: newRow.bottomAnchor, constant: 20).isActive = true
            row.setupRow(type: setting.accessoryType)
            previousRow = row
            counter = counter+1
        }
        reportABug()
    }
    
    func reportABug()  {
        guard let controller = controller else {return}
        let row = RowView()
        scroller.addSubview(row)
        row.titleView.text = "Something isn't working"
        row.iconView.image = UIImage(named: "Bug")?.withRenderingMode(.alwaysTemplate) // add this so we can add a tint
        row.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        row.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        guard let newRow = previousRow else {return} // get the hell out. TO DO add an alertviewcontroller and clean the view "Cannot get data" or something like that
        row.topAnchor.constraint(equalTo: newRow.bottomAnchor, constant: 20).isActive = true
        row.setupRow(type: PrivacyAccessoryType.none)
        row.bottomAnchor.constraint(equalTo: scroller.bottomAnchor, constant: 10).isActive = true
    }
    
    //MARK: Handle UI Updates
    func handlePrivacyUpdate(){
        guard let controller = controller else {return}
        
        controller.interactor.updateUI = { [weak self] (button) in
            if let weakSelf = self{
                weakSelf.previouslySelectedPrivacyOption?.isSelected = false
                weakSelf.previouslySelectedPrivacyOption?.tintColor = iconGrey
                button.tintColor = navbarColour
                weakSelf.previouslySelectedPrivacyOption = button
                if button.tag == 0{
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        weakSelf.collapsableRow?.alpha = 0.0
                        weakSelf.disclaimerMessage.alpha = 1.0
                    }, completion: { (succes) in
                        weakSelf.collapsableRow?.isHidden = true
                    })
                }else{
                    UIView.animate(withDuration: 0.3, animations: {
                        weakSelf.collapsableRow?.isHidden = false
                        weakSelf.disclaimerMessage.alpha = 0.0
                        weakSelf.collapsableRow?.alpha = 1.0
                    })
                }
            }
        }
    }
    
}
