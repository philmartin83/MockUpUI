//
//  StorySettingsViewController.swift
//  MockUpUI
//
//  Created by Philip Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class StorySettingsViewController: UIViewController {
    
    var presenter = StorySettingsPresenter()
    var interactor = StorySettingsInteractor()
    weak var navController: BaseNavigationViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = storySettingsViewControllerBakcgroundColour
        
        presenter.controller = self
        interactor.controller = self
        presenter.displayLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.setupNavBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}
