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
@testable import HalfTunes

class TunesTableViewControllerTests: XCTestCase {

  func testSearch_UpdatesTable_UponSuccessfulSearch() {

    class MockTableView: UITableView {
      var reloadCalled = false

      override func reloadData() {
        reloadCalled = true
      }
    }

    class MockQueryService: QueryService {
      let tunes = [Tune(artist: "Taylor Swift", name: "Shake It Off", releaseDate: Date())]
      override func getSearchResults(searchTerm: String, completion: @escaping ([Tune]?) -> ()) {
        completion(tunes)
      }
    }

    let toTest = TunesTableViewController()
    let mockTableView = MockTableView()
    let mockQueryService = MockQueryService()
    toTest.tableView = mockTableView
    toTest.queryService = mockQueryService

    let searchTerm = "Taylor Swift"
    toTest.search(searchTerm: searchTerm)

    XCTAssertTrue(mockTableView.reloadCalled)
    XCTAssertEqual(mockQueryService.tunes.first?.artist, toTest.tunes!.first?.artist)
    XCTAssertEqual(mockQueryService.tunes.first?.name, toTest.tunes!.first?.name)
  }

  func testDidSelectRow_OpensURL_WhenSelected() {

    class MockUIApplication: URLOpening {
      var openCalled = false
      func open(_ url: URL, options: [String : Any], completionHandler: ((Bool) -> Void)?) {
        openCalled = true
      }
    }

    let toTest = TunesTableViewController()
    let aTune = Tune(artist: "Taylor Swift", name: "Blank Space", releaseDate: Date(), trackViewUrl: "http://www.taylorswift.com")
    toTest.tunes = [aTune]
    let mockApplication = MockUIApplication()
    toTest.application = mockApplication

    toTest.tableView(toTest.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))

    XCTAssertTrue(mockApplication.openCalled)

  }
}
