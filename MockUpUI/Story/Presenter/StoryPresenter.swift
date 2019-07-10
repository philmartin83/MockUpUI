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
    
    func displayLayout() {
        
        guard let controller = controller else {return}
        controller.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
            
            try? self.cameraController.displayPreview(on: self)
        }
        
    }
}
