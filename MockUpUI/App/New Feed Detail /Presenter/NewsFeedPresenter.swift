//
//  NewsFeedPresenter.swift
//  MockUpUI
//
//  Created by Philip Martin on 13/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class NewsFeedPresenter: UIView, LayoutProtocol, NavigationBarProtocol{
    
    weak var controller: NewsFeedViewController?
    weak var dataSource: NewsFeedDataSource?
    
    lazy var headerImageView: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    lazy var scroller: UIScrollView = {
        let scroller = UIScrollView()
        scroller.translatesAutoresizingMaskIntoConstraints = false
        return scroller
    }()
    
    
    
    func setupNavBar() {
        
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
    
    func displayLayout() {
        guard let controller = controller else {return}
        controller.view.addSubview(scroller)
        scroller.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        scroller.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        
        // handly the update of the UI
        dataSource?.updateUIWithNewsFeedData = { [weak self] (feed) in
            if let weakSelf = self{
                if feed == nil{
                    // alertviewcontroller to go here
                }else{
                    // display in the UI
                }
            }
        }
    }
    
}
