//
//  DogYearsUITests.swift
//  DogYearsUITests
//
//  Created by Brian on 12/13/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import XCTest

class DogYearsUITests: XCTestCase {
  
    private var app: XCUIApplication!
  
  
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
      
      let navBar = app.navigationBars["Master"]
      let button = navBar.buttons["Menu"]
      button.tap()
      XCTAssertFalse(navBar.exists, "The old navigation bar no longer exists")
      let nav2 = app.navigationBars["Menu"]
      XCTAssert(nav2.exists, "The new navigation bar does not exist")
 
      
      
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
