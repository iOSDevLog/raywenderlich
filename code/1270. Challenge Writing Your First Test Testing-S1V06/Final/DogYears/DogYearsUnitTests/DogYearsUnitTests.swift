//
//  DogYearsUnitTests.swift
//  DogYearsUnitTests
//
//  Created by Brian on 11/30/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import XCTest
@testable import DogYears

class DogYearsUnitTests: XCTestCase {
  
    let calc = Calculator()
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAdd() {
      let result = calc.evaluate(op: "+", arg1: 2.0, arg2: 9.0)
      XCTAssert(result == 11.0, "Calculator add operation failed")
    }
  
    func testSubtract() {
      
      let result = calc.evaluate(op: "-", arg1: 9.0, arg2: 2.0)
      XCTAssert(result == 7.0, "Calculator subtraction operation failed")
      
    }
  

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
