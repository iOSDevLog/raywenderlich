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
  
    func testInfoViewNavigation() {
    
      let app = XCUIApplication()
      
      
      app.navigationBars["Master"].buttons["Menu"].tap()
      
      
      
      app.tables/*@START_MENU_TOKEN@*/.staticTexts["Information"]/*[[".cells.staticTexts[\"Information\"]",".staticTexts[\"Information\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      let nav = app.navigationBars["Information"]
      XCTAssert(nav.exists, "The information view navigation bar does not exist")
    
    }
  
    func testSettingsNavigation() {
    
      let app = XCUIApplication()
      app.navigationBars["Master"].buttons["Menu"].tap()
      app.tables.staticTexts["Settings"].tap()
      let nav = app.navigationBars["Settings"]
      XCTAssert(nav.exists, "The Settings view navigation bar does not exist")
    
    }
  
    func testAboutNavigation() {
    
      let app = XCUIApplication()
      app.navigationBars["Master"].buttons["Menu"].tap()
      app.tables.staticTexts["About"].tap()
      let nav = app.navigationBars["About"]
      XCTAssert(nav.exists, "The About view navigation bar does not exist")
    
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
