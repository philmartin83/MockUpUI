//
//  NewsFeedViewController.swift
//  MockUpUI
//
//  Created by Philip Martin on 13/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    weak var navController: BaseNavigationViewController?
    let interactor = NewsFeedInteractor()
    let presenter = NewsFeedPresenter()
    let dataSource = NewsFeedDataSource()
    let alertController = Alert()
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = navbarColour
        presenter.controller = self
        interactor.controller = self
        presenter.dataSource = dataSource
        presenter.setupNavBar()
        // display the layout
        presenter.displayLayout()
        // load our data source from the passed index of the tapped UITableViewCell
        dataSource.fetchNewsFeedItemById(id: index)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
