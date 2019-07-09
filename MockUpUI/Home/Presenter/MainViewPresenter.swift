//
//  Presenter.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

import Foundation

class MainViewPresenter: UIView, NavigationBarProtocol, LayoutProtocol, UITableViewDataSource, UITableViewDelegate {
    
    weak var controller: ViewController?
    var tableView: UITableView = {
        let tV = UITableView()
        tV.backgroundColor = .clear
        tV.translatesAutoresizingMaskIntoConstraints = false
        tV.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return tV
    }()
    
    var holderView: UIView = {
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
        
        controller?.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: controller!.view.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: controller!.view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: controller!.view.bottomAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: controller!.view.rightAnchor).isActive = true
    
        self.addSubview(holderView)
        holderView.translatesAutoresizingMaskIntoConstraints = false
        holderView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        holderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        holderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        holderView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        holderView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: holderView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: holderView.rightAnchor).isActive = true
        tableView.showsVerticalScrollIndicator = false
        // Time to register our cells
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(FriendsListTableViewCell.self, forCellReuseIdentifier: "FriendsCell")
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1{
            return 1
        }else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 500
        }else if indexPath.section == 1{
            return 420
        }
        return 320
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let profileSectionCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileTableViewCell
            profileSectionCell.styleUITableViewCell()
            profileSectionCell.name.text = "Panthro"
            profileSectionCell.bio.text = "Add a short bio to tell people more about yourself"
            tableView.separatorStyle = .none
            profileSectionCell.addBioButton.addTarget(controller?.interactor, action: #selector(controller?.interactor.presentBioScreen), for: .touchUpInside)
            return profileSectionCell // we can force unwrap here as have already init'd above.
            
        }else if indexPath.section == 1{
            
            let friendsCell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell") as! FriendsListTableViewCell
            tableView.separatorStyle = .none
            friendsCell.styleUITableViewCell()
            return friendsCell
        }else{
            var tableViewCell = tableView.dequeueReusableCell(withIdentifier: "StandardCell")
            if tableViewCell == nil {
                tableViewCell = UITableViewCell(style: .default, reuseIdentifier: "StandardCell")
            }
            tableView.separatorStyle = .singleLine
            return tableViewCell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 1{
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100)
            view.backgroundColor = primaryColour
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "News Feed"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: mediumBoldFontSize)
            label.textColor = .white
            view.addSubview(label)
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            return view
            
        }
        return nil
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 1{
            return 90
        }
        return 0
    }
    
    
}
