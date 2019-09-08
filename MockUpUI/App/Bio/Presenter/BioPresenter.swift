//
//  BioPresenter.swift
//  MockUpUI
//
//  Created by Phil Martin on 09/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

final class BioPresenter: NavigationBarProtocol, LayoutProtocol{
    
    //MARK:- Properties
    weak var controller: BioViewController?
    var tvDelegate = BioTextViewDelegate()
    
    var holderView: UIView = {
        let holder = UIView()
        holder.supportDarkMode()
        holder.layer.cornerRadius = 40
        holder.clipsToBounds = true
        holder.translatesAutoresizingMaskIntoConstraints = false
        return holder
    }()
    
    lazy var bioTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.borderWidth = 1.5
        tv.text = bioTextViewplaceHolder
        tv.textColor = .lightGray
        tv.layer.borderColor = lightGray.cgColor
        tv.backgroundColor = .clear
        tv.layer.cornerRadius = 10
        tv.font = UIFont.systemFont(ofSize: 15)
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
        characterCount.font = UIFont.boldSystemFont(ofSize: 13)
        characterCount.textColor = lightGray
        characterCount.translatesAutoresizingMaskIntoConstraints = false
        return characterCount
    }()
    
    //MARK:- Protocol
    func displayLayout() {
        setupHolderView()
        setupTextViewAndCountAttributes()
        textCountViewUpdater()
        setupSaveButton()
    }
    
    //MARK:- View Setup
    func setupNavBar() {
        controller?.navController = controller?.navigationController as? BaseNavigationViewController
        guard let label = controller?.navController?.leftTitleLabel else {return}
        guard let button = controller?.navController?.backButton else {return}
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
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
    
    func setupHolderView(){
        guard let controller = controller else {return}
        controller.view.addSubview(holderView)
        holderView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        holderView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        holderView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        holderView.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
    }
    
    func setupTextViewAndCountAttributes(){
        guard let controller = controller else {return}
        tvDelegate.parentView = controller.view
        bioTextView.delegate = tvDelegate
        holderView.addSubview(bioTextView)
        bioTextView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 20).isActive = true
        bioTextView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -20).isActive = true
        
        bioTextView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 20).isActive = true
        bioTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        holderView.addSubview(characterCountLabel)
        characterCountLabel.trailingAnchor.constraint(equalTo: bioTextView.trailingAnchor).isActive = true
        characterCountLabel.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 15).isActive = true
        let bioString = UserDefaults.standard.string(forKey: bioTextKey)
        
        if let bio = bioString{
            bioTextView.text = bio
            bioTextView.textColor = .black
        }
        provideCounterLabelWithData(value: bioString?.count)
    }
    
    func setupSaveButton(){
        guard let controller = controller else {return}
        holderView.addSubview(saveButton)
        saveButton.trailingAnchor.constraint(equalTo: bioTextView.trailingAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: characterCountLabel.bottomAnchor, constant: 15).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButton.addTarget(controller.interactor, action: #selector(controller.interactor.saveBio), for: .touchUpInside )
    }
    
    //MARL:- Helper
    func provideCounterLabelWithData(value: Int?){
         characterCountLabel.text = "\(value ?? 0) / \(bioTextViewTextLength)"
    }
    
    //MARK:- View Change Closure
    func textCountViewUpdater(){
        // listen to textView updates so we can update the textview character count
        tvDelegate.updateTextViewCountLabel = { [weak self] (value) in
            if let weakSelf = self{
                weakSelf.provideCounterLabelWithData(value: value)
            }
        }
    }
    
}
