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
    
    let cameraController = CameraController()
    
    lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let backImage = UIImage(named: "Close")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .white
        return backButton
        
    }()
    
    lazy var settingsButton: UIButton = {
        let settingsButton = UIButton(type: .custom)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        let backImage = UIImage(named: "Settings")?.withRenderingMode(.alwaysTemplate)
        settingsButton.setImage(backImage, for: .normal)
        settingsButton.tintColor = .white
        return settingsButton
        
    }()
    
    lazy var flashOnOffButton: UIButton = {
        let flashBtn = UIButton(type: .custom)
        flashBtn.translatesAutoresizingMaskIntoConstraints = false
        let flashOffIcon = UIImage(named: "FlashOff")?.withRenderingMode(.alwaysTemplate)
        flashBtn.setImage(flashOffIcon, for: .normal)
        flashBtn.tintColor = .white
        return flashBtn
    }()
    
    lazy var videoCameraButton: UIButton = {
        let videoBtn = UIButton(type: .custom)
        videoBtn.translatesAutoresizingMaskIntoConstraints = false
        let videoIcon = UIImage(named: "VideoCamera")?.withRenderingMode(.alwaysTemplate)
        videoBtn.tintColor = .white
        videoBtn.setImage(videoIcon, for: .normal)
        return videoBtn
    }()
    
    lazy var cameraButton: UIButton = {
        let camera = UIButton(type: .custom)
        camera.translatesAutoresizingMaskIntoConstraints = false
        let cameraIcon = UIImage(named: "Camera")?.withRenderingMode(.alwaysTemplate)
        camera.tintColor = .white
        camera.setImage(cameraIcon, for: .normal)
        return camera
    }()
    
    lazy var shutterButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = shutterButtonWidthHeight/2
        return btn
    }()
    
    func displayLayout() {
        
        // button width and height size should be in the Constant.swift file so its easier to change in the future
        guard let controller = controller else {return}
        cameraController.prepare { [weak self] (error) in
            if let weakSelf = self {
                if let error = error {
                    print(error)
                    return
                }
                
                try? weakSelf.cameraController.displayPreview(on: controller.view)
            }
           
        }
        controller.view.addSubview(backButton)
        backButton.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: camerButtonsWidthHeight).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: camerButtonsWidthHeight).isActive = true
        backButton.topAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        backButton.addTarget(controller.interactor, action: #selector(controller.interactor.backToHome), for: .touchUpInside)
        
        controller.view.addSubview(settingsButton)
        settingsButton.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 30).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: camerButtonsWidthHeight).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: camerButtonsWidthHeight).isActive = true
        settingsButton.topAnchor.constraint(equalTo: backButton.topAnchor).isActive = true
        settingsButton.addTarget(controller.interactor, action: #selector(controller.interactor.displayStorySettings), for: .touchUpInside)
        
        controller.view.addSubview(flashOnOffButton)
        flashOnOffButton.trailingAnchor.constraint(equalTo: backButton.trailingAnchor).isActive = true
        flashOnOffButton.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        flashOnOffButton.widthAnchor.constraint(equalToConstant: camerButtonsWidthHeight).isActive = true
        flashOnOffButton.heightAnchor.constraint(equalToConstant: camerButtonsWidthHeight).isActive = true
        flashOnOffButton.addTarget(controller.interactor, action: #selector(controller.interactor.flashState), for: .touchUpInside)
        
        controller.view.addSubview(videoCameraButton)
        videoCameraButton.leadingAnchor.constraint(equalTo: settingsButton.leadingAnchor).isActive = true
        videoCameraButton.widthAnchor.constraint(equalToConstant: camerButtonsWidthHeight).isActive = true
        videoCameraButton.heightAnchor.constraint(equalToConstant: camerButtonsWidthHeight).isActive = true
        videoCameraButton.bottomAnchor.constraint(equalTo: flashOnOffButton.bottomAnchor).isActive = true
        
        controller.view.addSubview(cameraButton)
        cameraButton.leadingAnchor.constraint(equalTo: videoCameraButton.leadingAnchor).isActive = true
        cameraButton.widthAnchor.constraint(equalToConstant: camerButtonsWidthHeight).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: camerButtonsWidthHeight).isActive = true
        cameraButton.bottomAnchor.constraint(equalTo: videoCameraButton.topAnchor, constant: -25).isActive = true
        
        controller.view.addSubview(shutterButton)
        shutterButton.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
        shutterButton.bottomAnchor.constraint(equalTo: videoCameraButton.bottomAnchor).isActive = true
        shutterButton.widthAnchor.constraint(equalToConstant: shutterButtonWidthHeight).isActive = true
        shutterButton.heightAnchor.constraint(equalToConstant: shutterButtonWidthHeight).isActive = true
        shutterButton.addTarget(controller.interactor, action: #selector(controller.interactor.shutterButtonTapper), for: .touchUpInside)
        flashState()
        cameraType()
    }
    
    func flashState(){
        guard let controller = controller else {return}
        controller.interactor.updateFlashState = { [weak self] in
            if let weakSelf = self{
                if weakSelf.cameraController.flashMode == .on{
                    weakSelf.cameraController.flashMode = .off
                    weakSelf.flashOnOffButton.setImage(UIImage(named: "FlashOff")?.withRenderingMode(.alwaysTemplate), for: .normal)
                }else{
                    weakSelf.flashOnOffButton.setImage(UIImage(named: "FlashOn")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    weakSelf.cameraController.flashMode = .on
                }
            }
        }
    }
    
    func cameraType(){
//        guard let controller = controller else {return}
//        if cameraController
    }
}
