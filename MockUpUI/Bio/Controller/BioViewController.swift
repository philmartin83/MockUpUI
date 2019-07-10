//
//  BioViewController.swift
//  MockUpUI
//
//  Created by Phil Martin on 09/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class BioViewController: UIViewController {

    var navController: BaseNavigationViewController?
    var presenter = BioPresenter()
    var interactor = BioInteractor()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = primaryColour
        presenter.controller = self
        interactor.controller = self
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
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}
