//
//  Presenter.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

import Foundation

class MainViewPresenter: UIView, NavigationBarProtocol, LayoutProtocol {
    
    //MARK:- Provate Properties
    fileprivate let dataSource = HomeViewTableViewDataSource()
    fileprivate let delegate = HomeViewTableViewDelegate()
    
    //MARK:- Properties
    weak var controller: ViewController?
    lazy var tableView: UITableView = {
        let tV = UITableView()
        tV.supportDarkMode()
        tV.layer.cornerRadius = mainCornerRadius
        tV.translatesAutoresizingMaskIntoConstraints = false
        tV.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return tV
    }()
    
    //MARK:- Protocol
    func displayLayout(){
        setupDataSource()
        setupTableView()
    }
    
    //MARK:- Setup Views
    func setupNavBar(){
        
        controller?.navController = controller?.navigationController as? BaseNavigationViewController
        if let navController = controller?.navController {
            navController.navigationBar.barTintColor = navbarColour
        }
        
        guard let label = controller?.navController?.leftTitleLabel else {return}
        controller?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        controller?.navController?.leftTitleLabel.textColor = .white
        controller?.navController?.leftTitleLabel.text = "My Social App"
        // refresh our tableView
        tableView.reloadData()
    }
    
    func setupDataSource(){
//        dataSource.controller = controller
        dataSource.fetchData()
        
        dataSource.reloadClosure = { [weak self] in
            if let weakSelf = self{
                weakSelf.tableView.reloadData()
            }
        }
    }
    
    func setupTableView(){
        
        guard let controller = controller else {return}
        controller.view.addSubview(tableView)
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: controller.view.rightAnchor).isActive = true
        tableView.showsVerticalScrollIndicator = false
        // Time to register our cells
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(FriendsListTableViewCell.self, forCellReuseIdentifier: "FriendsCell")
        tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: "NewsFeed")
        
        // listen for our cell selection.
        delegate.pushControllerToStack = { [weak self] (rowID) in
            if let weakSelf = self{
                let vc = NewsFeedViewController()
                vc.index = rowID
                weakSelf.controller?.navController?.pushViewController(vc, animated: true)
            }
        }
        
        dataSource.presentSettingsClosure = { (sender) in
            controller.interactor.settings(sender: sender)
        }
        
        dataSource.loadAllFriendsClosure = { (sender) in
            controller.interactor.loadAllFriends(sender: sender)
        }
        
        dataSource.loadFullCameraClosure = { (sender) in
            controller.interactor.loadFullCamera(sender: sender)
        }
        
        dataSource.presentBioClosure = { (sender) in
            controller.interactor.presentBioScreen(sender: sender)
        }
    }
}
