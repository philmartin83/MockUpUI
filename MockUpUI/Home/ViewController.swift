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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.controller = self
        presenter.setupNavBar()
        view.backgroundColor = UIColor.colourStringWitHex(hexColour: "3232FF", withAlpha: 1)
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

