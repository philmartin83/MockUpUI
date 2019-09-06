//
//  MockUpUITests.swift
//  MockUpUITests
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import XCTest
@testable import MockUpUI

class MockUpUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testHome(){
        let home = ViewController()
        home.viewDidLoad()
        home.viewWillAppear(true)
        XCTAssertNotNil(home)
        XCTAssertNotNil(home.interactor)
        XCTAssertNotNil(home.presenter)
    }
    
    func testSettings(){
        let settings = StorySettingsViewController()
        settings.viewDidLoad()
        settings.viewWillAppear(false)
        XCTAssertNotNil(settings)
        XCTAssertNotNil(settings.interactor)
        XCTAssertNotNil(settings.presenter)
    }
    
    func testBio(){
        let bio = BioViewController()
        bio.viewDidLoad()
        bio.viewWillAppear(false)
        XCTAssertNotNil(bio)
        XCTAssertNotNil(bio.interactor)
        XCTAssertNotNil(bio.presenter)
    }
    
    func testNewsFeedDetail(){
        let newsFeed = NewsFeedViewController()
        newsFeed.viewDidLoad()
        newsFeed.viewWillAppear(true)
        XCTAssertNotNil(newsFeed.interactor)
        XCTAssertNotNil(newsFeed.presenter)
    }
    
    func testStory(){
        let story = StoryViewController()
        story.viewDidLoad()
        story.viewWillAppear(false)
        XCTAssertNotNil(story.interactor)
        XCTAssertNotNil(story.presenter)
    }
   

}
