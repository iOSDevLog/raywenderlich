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

class NewsAPI {
  
  static let service = NewsAPI()
  
  private enum API {
    private static let basePath = "https://newsapi.org/v1"
    /*
     Head on over to https://newsapi.org/register to get your
     free API key, and then replace the value below with it.
     */
    private static let key = "00000000000000000000000000000000"
    
    case sources
    case articles(Source)
    
    func fetch(completion: @escaping (Data) -> ()) {
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: path()) { (data, response, error) in
        guard let data = data, error == nil else { return }
        completion(data)
      }
      task.resume()
    }
    
    private func path() -> URL {
      switch self {
      case .sources:
        return URL(string: "\(API.basePath)/sources")!
      case .articles(let source):
        return URL(string: "\(API.basePath)/articles?source=\(source.id)&apiKey=\(API.key)")!
      }
    }
  }
  
  private(set) var sources: [Source] = []
  private(set) var articles: [Article] = []
  
  func fetchSources() {
    API.sources.fetch { data in
      if let json = String(data: data, encoding: .utf8) {
        print(json)
      }
    }
  }
  
  func fetchArticles(for source: Source) {
    API.articles(source).fetch { data in
      
    }
  }
  
  func resetArticles() {
    articles = []
  }
}
