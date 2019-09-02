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
        imageV.contentMode = .scaleAspectFill
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    lazy var titleView: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.text = "" // default empty string
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        return title
    }()
    
    lazy var detailText: UILabel = {
        let detail = UILabel()
        detail.numberOfLines = 0
        detail.text = "" // default empty string
        detail.font = UIFont.systemFont(ofSize: bodyFontSize)
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.textColor = .black
        return detail
    }()
    
    lazy var scroller: UIScrollView = {
        let scroller = UIScrollView()
        scroller.backgroundColor = .white
        scroller.layer.cornerRadius = mainCornerRadius
        scroller.translatesAutoresizingMaskIntoConstraints = false
        return scroller
    }()
    
    lazy var articleDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
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
            navController.navigationBar.barTintColor = navbarColour
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
        scroller.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        scroller.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        
        scroller.addSubview(headerImageView)
        headerImageView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 10).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -10).isActive = true
        headerImageView.topAnchor.constraint(equalTo: scroller.topAnchor, constant: 60).isActive = true
        headerImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        scroller.addSubview(titleView)
        titleView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 10).isActive = true
        titleView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -20).isActive = true
        titleView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 50).isActive = true
        
        scroller.addSubview(articleDateLabel)
        articleDateLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor).isActive = true
        articleDateLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        articleDateLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20).isActive = true
        
        scroller.addSubview(detailText)
        detailText.leadingAnchor.constraint(equalTo: titleView.leadingAnchor).isActive = true
        detailText.trailingAnchor.constraint(equalTo: titleView.trailingAnchor).isActive = true
        detailText.topAnchor.constraint(equalTo: articleDateLabel.bottomAnchor, constant: 20).isActive = true
        
        // handly the update of the UI
        dataSource?.updateUIWithNewsFeedData = { [weak self] (feed) in
            if let weakSelf = self{
                if feed == nil{
                    // handle my custom alert controller
                    controller.present(controller.alertController.showAlertForBadData(title: "Error", body: "Unable to get news feed right now."), animated: true, completion: nil)
                    
                }else{
                    // display in the UI
                    weakSelf.articleDateLabel.text = Date().convertServerDateTime(dateString: feed?.date)
                    weakSelf.detailText.text = feed?.body
                    weakSelf.headerImageView.image = UIImage().base64Decode(strBase64: feed?.image)
                    weakSelf.titleView.text = feed?.title
                    weakSelf.layoutSubviews()
                }
            }
        }
        detailText.bottomAnchor.constraint(equalTo: scroller.bottomAnchor, constant: -20).isActive = true
        
    }
    
}
