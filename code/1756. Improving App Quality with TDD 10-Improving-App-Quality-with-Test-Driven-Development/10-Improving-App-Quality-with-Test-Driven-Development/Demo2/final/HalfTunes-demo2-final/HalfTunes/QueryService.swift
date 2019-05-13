/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

class QueryService {

  struct QueryResponse: Decodable {
    let resultCount: Int
    let results: [Tune]
  }

  func getSearchResults(searchTerm: String, completion: @escaping ([Tune]?) -> ()) {
    guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)") else {
      return
    }

    let dataTask = URLSession(configuration: .default).dataTask(with: url) { [weak self] (data, response, error) in
      if let _ = error {
        completion(nil)
        return
      }
      guard let strongSelf = self,
        let data = data else {
          return
      }
      let tunes = strongSelf.createTunesFrom(data: data)
      completion(tunes)
    }

    dataTask.resume()
  }

  func createTunesFrom(data: Data) -> [Tune] {
    var toReturn: [Tune] = []
    do {
      toReturn = try JSONDecoder().decode(QueryResponse.self, from: data).results
    } catch let error {
      // do nothing
      print(error)
    }
    return toReturn
  }
}