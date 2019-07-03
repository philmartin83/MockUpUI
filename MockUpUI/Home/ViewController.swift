//
//  ViewController.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var navController: BaseNavigationViewController?
    
    fileprivate var presenter = MainViewPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.controller = self
        navController = self.navigationController as? BaseNavigationViewController
        navController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .blue
        guard let label = navController?.leftTitleLabel else {return}
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        view.addSubview(presenter)
        presenter.displayLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

