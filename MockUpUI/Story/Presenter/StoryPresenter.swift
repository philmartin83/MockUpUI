//
//  StoryPresenter.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class StoryPresenter: UIView, LayoutProtocol {
    
    weak var controller: StoryViewController?
    
    fileprivate let cameraController = CameraController()
    
    lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let backImage = UIImage(named: "BackStory")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .white
        return backButton
        
    }()
    
    lazy var settingsSutton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let backImage = UIImage(named: "Settings")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .white
        return backButton
        
    }()
    
    func displayLayout() {
        
        guard let controller = controller else {return}
        controller.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        
        cameraController.prepare { [weak self] (error) in
            if let weakSelf = self {
                if let error = error {
                    print(error)
                    // need to add some default code if the camera is not available
                    weakSelf.setupLayoutWhenCameraIsNotAvailable()
                    return
                }
                
                try? weakSelf.cameraController.displayPreview(on: weakSelf)
            }
           
        }
        addBackButton()
        self.addSubview(settingsSutton)
        settingsSutton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        settingsSutton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        settingsSutton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        settingsSutton.topAnchor.constraint(equalTo: backButton.topAnchor).isActive = true
        settingsSutton.addTarget(controller.interactor, action: #selector(controller.interactor.displayStorySettings), for: .touchUpInside)
        
    }
    
    func addBackButton(){
        guard let controller = controller else {return}
        self.addSubview(backButton)
        backButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        backButton.addTarget(controller.interactor, action: #selector(controller.interactor.backToHome), for: .touchUpInside)
    }
    
    func setupLayoutWhenCameraIsNotAvailable(){
        addBackButton()
    }
}
