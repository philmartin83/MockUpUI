//
//  StoryViewController.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    
    var presenter = StoryPresenter()
    var interactor = StoryInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        presenter.controller = self
        interactor.controller = self
        presenter.displayLayout()
        view.backgroundColor = .black
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
