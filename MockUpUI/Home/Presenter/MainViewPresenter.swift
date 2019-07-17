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
    
    
    fileprivate let dataSource = HomeViewTableViewDataSource()
    fileprivate let delegate = HomeViewTableViewDelegate()
    
    weak var controller: ViewController?
    lazy var tableView: UITableView = {
        let tV = UITableView()
        tV.backgroundColor = .clear
        tV.translatesAutoresizingMaskIntoConstraints = false
        tV.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return tV
    }()
    
    lazy var holderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    func setupNavBar(){
        
        controller?.navController = controller?.navigationController as? BaseNavigationViewController
        controller?.navController?.navigationBar.shadowImage = UIImage()
        
        if let navController = controller?.navController {
            navController.navigationBar.barTintColor = navbarColour
        }
        
        guard let label = controller?.navController?.leftTitleLabel else {return}
        controller?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        controller?.navController?.leftTitleLabel.textColor = .white
        controller?.navController?.leftTitleLabel.text = "My Social App"
    }
    
    func displayLayout(){
        guard let controller = controller else {return}
       
        controller.view.addSubview(holderView)
        holderView.translatesAutoresizingMaskIntoConstraints = false
        holderView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        holderView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        holderView.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        holderView.rightAnchor.constraint(equalTo: controller.view.rightAnchor).isActive = true
        
        holderView.addSubview(tableView)
        dataSource.controller = controller
        dataSource.fetchData()
        
        dataSource.reloadClosure = { [weak self] in
            if let weakSelf = self{
                weakSelf.tableView.reloadData()
            }
        }
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: holderView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: holderView.rightAnchor).isActive = true
        tableView.showsVerticalScrollIndicator = false
        // Time to register our cells
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(FriendsListTableViewCell.self, forCellReuseIdentifier: "FriendsCell")
        tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: "NewsFeed")
    
    }
    
}
