//
//  HomeViewTableViewDelegate.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class HomeViewTableViewDelegate: NSObject, UITableViewDelegate {
    
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // only get the last section
        if indexPath.section == tableViewSections - 1{
            tableView.deselectRow(at: indexPath, animated: true)
            let vc = NewsFeedViewController()
            vc.index = indexPath.row
        }
    }
    
}
