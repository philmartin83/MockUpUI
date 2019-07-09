//
//  ViewController.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:-Properties
    var navController: BaseNavigationViewController?
    var presenter = MainViewPresenter()
    var interactor = MainViewInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.controller = self
        interactor.viewController = self
        view.backgroundColor = navbarColour
        presenter.displayLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
        presenter.setupNavBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

