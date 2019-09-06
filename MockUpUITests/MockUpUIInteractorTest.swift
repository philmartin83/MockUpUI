//
//  MockUpUIInteractorTest.swift
//  MockUpUITests
//
//  Created by Phil Martin on 06/09/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import XCTest
@testable import MockUpUI

class MockUpUIInteractorTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSettingsInteractor(){
        let interactor = StorySettingsInteractor()
        interactor.closeSettings()
        let btn = UIButton(type: .custom)
        interactor.togglePrivacyState(sender: btn)
        interactor.updateUI?(btn)
    }
    
    func testStoryInteractor(){
        let btn = UIButton(type: .custom)
        let interactor = StoryInteractor()
        interactor.backToHome(sender: btn)
        interactor.displayStorySettings(sender: btn)
        interactor.flashState(sender: btn)
        interactor.shutterButtonTapper(sender: btn)
        interactor.updateFlashState?()
    }
    
    func testBioInteractor(){
        let btn = UIButton(type: .custom)
        let interactor = BioInteractor()
        interactor.popviewController()
        interactor.saveBio(sender: btn)
    }
    
    func testHomeInteractor(){
        let btn = UIButton(type: .custom)
        let interactor = MainViewInteractor()
        interactor.loadAllFriends(sender: btn)
        interactor.loadFullCamera(sender: btn)
        interactor.presentBioScreen(sender: btn)
        interactor.settings(sender: btn)
    }
    
    func testNewsFeedInteractor(){
        let interactor = NewsFeedInteractor()
        interactor.popviewController()
    }

}
