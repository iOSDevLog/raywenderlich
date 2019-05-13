/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import Counts

class CountsPresenterTests: XCTestCase {

  func testInsertingACountWillReturnAnUpdateWithOneItem() {
    let incrementExpectation = expectation(description: "Increment callback wasn't triggered")
    let mockView = MockCountsView(expectation: incrementExpectation)
    let presenter = CountsPresenter(countsView: mockView)
    presenter.getCounts()

    presenter.insert(Count(id: nil, title: "hello", count: 0, total: 2, interval: .weekly, resetTime: nil, increment: 0))
    wait(for: [incrementExpectation], timeout: 1.0)

    XCTAssertEqual(mockView.insertionUpdate?.counts.count, mockView.initialCounts.count + 1)
  }

  func testInsertingACountWillReturnAnItemWithTheSameTitle() {
    let incrementExpectation = expectation(description: "Increment callback wasn't triggered")
    let mockView = MockCountsView(expectation: incrementExpectation)
    let presenter = CountsPresenter(countsView: mockView)
    presenter.getCounts()

    let countRequest = Count(id: nil, title: "hello", count: 0, total: 2, interval: .weekly, resetTime: nil, increment: 0)
    presenter.insert(countRequest)

    wait(for: [incrementExpectation], timeout: 1.0)
    XCTAssertEqual(mockView.insertionUpdate?.firstUpdatedCount?.title, countRequest.title)
  }
}

class MockCountsView: CountsView {

  private let expectation: XCTestExpectation
  var insertionUpdate: IncrementalUpdate?
  var initialCounts: [Count] = []

  init(expectation: XCTestExpectation) {
    self.expectation = expectation
  }

  func onCountsUpdated(_ counts: [Count]) {
    self.initialCounts = counts
  }

  func onCountInserted(_ update: IncrementalUpdate) {
    insertionUpdate = update
    expectation.fulfill()
  }

  func onCountIncremented(_ newCount: IncrementalUpdate) {

  }

  func onCountsNotLoaded(with error: Error) {
    
  }
}

extension IncrementalUpdate {

  var firstUpdatedCount: Count? {
    guard let firstUpdateId = updated.first else {
      return nil
    }
    return counts.first(where: { count in
      return count.id == firstUpdateId
    })
  }
}