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
    
    func setupNavBar() {
        controller?.navController = controller?.navigationController as? BaseNavigationViewController
        controller?.navController?.navigationBar.shadowImage = UIImage()
        controller?.navController?.navigationItem.hidesBackButton = true
        guard let label = controller?.navController?.leftTitleLabel else {return}
        guard let button = controller?.navController?.backButton else {return}
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
        controller.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        
        self.addSubview(holderView)
        holderView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        holderView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        holderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        holderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
}
