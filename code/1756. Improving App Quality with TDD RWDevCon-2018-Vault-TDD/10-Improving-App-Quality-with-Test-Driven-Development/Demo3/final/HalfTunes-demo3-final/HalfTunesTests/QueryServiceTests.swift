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
import Mockingjay
@testable import HalfTunes

class QueryServiceTests: XCTestCase {

  let sampleResponse = "{\"resultCount\":1,\"results\":[{\"artistId\":909253,\"artistName\":\"Jack Johnson\",\"artistViewUrl\":\"https://itunes.apple.com/us/artist/jack-johnson/id909253?uo=4\",\"artworkUrl100\":\"http://is1.mzstatic.com/image/thumb/Music2/v4/a2/66/32/a2663205-663c-8301-eec7-57937c2d0878/source/100x100bb.jpg\",\"artworkUrl30\":\"http://is1.mzstatic.com/image/thumb/Music2/v4/a2/66/32/a2663205-663c-8301-eec7-57937c2d0878/source/30x30bb.jpg\",\"artworkUrl60\":\"http://is1.mzstatic.com/image/thumb/Music2/v4/a2/66/32/a2663205-663c-8301-eec7-57937c2d0878/source/60x60bb.jpg\",\"collectionCensoredName\":\"In Between Dreams\",\"collectionExplicitness\":\"notExplicit\",\"collectionId\":879273552,\"collectionName\":\"In Between Dreams\",\"collectionPrice\":7.99,\"collectionViewUrl\":\"https://itunes.apple.com/us/album/better-together/id879273552?i=879273565&uo=4\",\"country\":\"USA\",\"currency\":\"USD\",\"discCount\":1,\"discNumber\":1,\"isStreamable\":true,\"kind\":\"song\",\"previewUrl\":\"https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/Music6/v4/13/22/67/1322678b-e40d-fb4d-8d9b-3268fe03b000/mzaf_8818596367816221008.plus.aac.p.m4a\",\"primaryGenreName\":\"Rock\",\"releaseDate\":\"2005-03-01T08:00:00Z\",\"trackCensoredName\":\"Better Together\",\"trackCount\":15,\"trackExplicitness\":\"notExplicit\",\"trackId\":879273565,\"trackName\":\"Better Together\",\"trackNumber\":1,\"trackPrice\":1.29,\"trackTimeMillis\":207679,\"trackViewUrl\":\"https://itunes.apple.com/us/album/better-together/id879273552?i=879273565&uo=4\",\"wrapperType\":\"track\"}]}".data(using: .utf8)!

  func testQueryService_ToCreateTunes_FromJSON() {
    let toTest = QueryService()

    let result = toTest.createTunesFrom(data: sampleResponse)
    let firstTune = result[0]

    XCTAssertEqual("Jack Johnson", firstTune.artist)
  }

  func testQueryService_AccessesAPI_AndReturnsCorrectResult() {
    let toTest = QueryService()
    let termToSearchFor = "phish"

    let url = "https://itunes.apple.com/search?term=\(termToSearchFor)"
    let body:[String: Any] = ["resultCount": 1,
                              "results": [
                                [
                                  "artistName": "Phish",
                                  "trackName": "Farmhouse",
                                  "releaseDate": "2000-05-16T07:00:00Z"
                                ]
                              ]
                             ]
    stub(http(.get, uri: url), json(body))

    let expectation = XCTestExpectation(description: "Call web service")

    toTest.getSearchResults(searchTerm: termToSearchFor) { (tunes) in
      XCTAssertEqual(tunes?[0].artist, "Phish")
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 2.0)
  }

  func testQueryService_ReturnsNil_WhenError() {
    let toTest = QueryService()
    let termToSearchFor = "phish"

    let url = "https://itunes.apple.com/search?term=\(termToSearchFor)"

    let stubbedError = NSError(domain: "Fake Error", code: 0, userInfo: nil)
    stub(http(.get, uri: url), failure(stubbedError))

    let expectation = XCTestExpectation(description: "Call web service")

    toTest.getSearchResults(searchTerm: termToSearchFor) { (tunes) in
      XCTAssertNil(tunes)
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 2.0)
  }
}
