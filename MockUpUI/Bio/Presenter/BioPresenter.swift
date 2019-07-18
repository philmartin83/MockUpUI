//
//  BioPresenter.swift
//  MockUpUI
//
//  Created by Phil Martin on 09/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class BioPresenter: UIView, NavigationBarProtocol, LayoutProtocol{
    
    weak var controller: BioViewController?
    
    var holderView: UIView = {
        let holder = UIView()
        holder.backgroundColor = .white
        holder.layer.cornerRadius = 40
        holder.clipsToBounds = true
        holder.translatesAutoresizingMaskIntoConstraints = false
        return holder
    }()
    
    lazy var bioTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.borderWidth = 0.1
        tv.layer.borderColor = lightGray.cgColor
        return tv
    }()
    
    lazy var saveButton: UIButton = {
        let saveBtn = UIButton(type: .custom)
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.backgroundColor = primaryColour
        saveBtn.layer.cornerRadius = buttonCornerRadius
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return saveBtn
    }()
    
    lazy var characterCountLabel: UILabel = {
        let characterCount = UILabel()
        characterCount.font = UIFont.systemFont(ofSize: 12)
        characterCount.textColor = lightGray
        return characterCount
    }()
    
    func setupNavBar() {
        controller?.navController = controller?.navigationController as? BaseNavigationViewController
        controller?.navController?.navigationBar.shadowImage = UIImage()
        controller?.navController?.navigationItem.hidesBackButton = true
        guard let label = controller?.navController?.leftTitleLabel else {return}
        guard let button = controller?.navController?.backButton else {return}
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.tintColor = .white
        
        let item1 = UIBarButtonItem(customView: button)
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        fixedSpace.width = 10.0
        let item2 = UIBarButtonItem(customView: label)
        
        if let navController = controller?.navController {
            navController.navigationBar.barTintColor = primaryColour
        }
        button.addTarget(controller?.interactor, action: #selector(controller?.interactor.popviewController), for: .touchUpInside)
        controller?.navigationItem.leftBarButtonItems = [item1,fixedSpace,item2]
        controller?.navController?.leftTitleLabel.textColor = .white
        controller?.navController?.leftTitleLabel.text = "Add Bio"
    }
    
    func displayLayout() {
        guard let controller = controller else {return}
        controller.view.addSubview(holderView)
        holderView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        holderView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        holderView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        holderView.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        
        holderView.addSubview(bioTextView)
        bioTextView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 20).isActive = true
        bioTextView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -20).isActive = true
      
        bioTextView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 20).isActive = true
        bioTextView.heightAnchor.constraint(equalToConstant: 100)
        
        holderView.addSubview(characterCountLabel)
        characterCountLabel.trailingAnchor.constraint(equalTo: bioTextView.trailingAnchor).isActive = true
        characterCountLabel.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 15).isActive = true
        
        holderView.addSubview(saveButton)
        saveButton.trailingAnchor.constraint(equalTo: bioTextView.trailingAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: characterCountLabel.bottomAnchor, constant: 15).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 100)
        saveButton.addTarget(controller.interactor, action: #selector(controller.interactor.saveBio), for: .touchUpInside )
        
    }
}
