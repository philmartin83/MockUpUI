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
        imageV.contentMode = .scaleAspectFit
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    lazy var titleView: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.text = "" // default empty string
        title.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var detailText: UILabel = {
        let detail = UILabel()
        detail.numberOfLines = 0
        detail.text = "" // default empty string
        detail.font = UIFont.systemFont(ofSize: bodyFontSize)
        detail.translatesAutoresizingMaskIntoConstraints = false
        return detail
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
        controller?.navController?.leftTitleLabel.text = "News Detail"
        
    }
    
    func displayLayout() {
        guard let controller = controller else {return}
        controller.view.addSubview(scroller)
        scroller.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        scroller.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        
        scroller.addSubview(headerImageView)
        headerImageView.leadingAnchor.constraint(equalTo: scroller.leadingAnchor, constant: 10).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: scroller.trailingAnchor, constant:  -20).isActive = true
        headerImageView.topAnchor.constraint(equalTo: scroller.topAnchor, constant: 10).isActive = true
        headerImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        scroller.addSubview(titleView)
        titleView.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: headerImageView.trailingAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10).isActive = true
        
        // handly the update of the UI
        dataSource?.updateUIWithNewsFeedData = { [weak self] (feed) in
            if let weakSelf = self{
                if feed == nil{
                    // alertviewcontroller to go here
                    let alertController = controller.alertController.showAlertForBadData(title: "Error", body: "error fetching data from the bundle")
                    // present the alert controller when there isn't any bundle data.
                    controller.present(alertController, animated: true, completion: nil)
                }else{
                    // display in the UI
                    weakSelf.titleView.text = feed?.title
                    weakSelf.headerImageView.image = UIImage().base64Decode(strBase64: feed?.image)
                    weakSelf.detailText.text = feed?.data
                }
            }
        }
        detailText.bottomAnchor.constraint(equalTo: scroller.bottomAnchor, constant: -20).isActive = true
        
    }
    
}
