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

typealias QueryResult = ([Track]?, String) -> ()

class QueryOperation: AsyncOperation {
  let defaultSession = URLSession(configuration: .default)
  var task: URLSessionDataTask?
  private let url: URL
  private let completion: QueryResult?
  private var tracks: [Track] = []
  var errorMessage = ""
  let decoder = JSONDecoder()
  
  init(url: URL, completion: @escaping QueryResult) {
    self.url = url
    self.completion = completion
    super.init()
  }
  
  override func main() {
    task = defaultSession.dataTask(with: url) { data, response, error in
      defer { self.task = nil }
      if let error = error {
        self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
      } else if let data = data,
        let response = response as? HTTPURLResponse,
        response.statusCode == 200,
        let completion = self.completion {
        self.updateSearchResults(data)
        DispatchQueue.main.async {
          completion(self.tracks, self.errorMessage)
        }
        self.state = .finished
      }
    }
    task?.resume()
  }
  
  // MARK: - Helper methods
  fileprivate func updateSearchResults(_ data: Data) {
    tracks.removeAll()
    do {
      let list = try decoder.decode(TrackList.self, from: data)
      tracks = list.results
    } catch let decodeError as NSError {
      errorMessage += "Decoder error: \(decodeError.localizedDescription)"
      return
    }
  }
  
}

