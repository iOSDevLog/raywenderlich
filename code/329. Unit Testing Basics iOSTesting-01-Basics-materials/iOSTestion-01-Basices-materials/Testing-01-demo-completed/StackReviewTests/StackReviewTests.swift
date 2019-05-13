//
//  StackReviewTests.swift
//  StackReviewTests
//
//  Created by Greg Heo on 2015-09-30.
//  Copyright © 2015 Razeware. All rights reserved.
//

import XCTest
@testable import StackReview

class StackReviewTests: XCTestCase {
  let collection = PancakeHouseCollection()

  override func setUp() {
    super.setUp()

    collection.loadTestData()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testCollectionHasItems() {
    XCTAssertGreaterThan(collection.count, 0, "Collection didn't have at least one item!")
  }


}
