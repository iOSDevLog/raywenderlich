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

import KituraKit

enum EmojiClientError: Error {
  case couldNotLoadEntries
  case couldNotAdd(JournalEntry)
  case couldNotDelete(JournalEntry)
  case couldNotCreateClient
}

// MARK: - UIApplication isDebugMode
extension UIApplication {
  var isDebugMode: Bool {
    let dictionary = ProcessInfo.processInfo.environment
    return dictionary["DEBUGMODE"] != nil
  }
}

class EmojiClient {
  private static var baseURL: String {
    return UIApplication.shared.isDebugMode ? "http://localhost:8080" : "https://david-okun-emojijournal.mybluemix.net"
  }
  
  static func getAll(completion: @escaping (_ entries: [JournalEntry]?, _ error: EmojiClientError?) -> Void) {
    guard let client = KituraKit(baseURL: baseURL) else {
      return completion(nil, EmojiClientError.couldNotCreateClient)
    }
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    client.get("/entries") { (entries: [JournalEntry]?, error: RequestError?) in
      DispatchQueue.main.async {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let _ = error {
          return completion(nil, EmojiClientError.couldNotLoadEntries)
        }
        completion(entries?.sorted(by: {
          $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970
        }), nil)
      }
    }
  }
  
  static func add(entry: JournalEntry, completion: @escaping (_ entry: JournalEntry?, _ error: EmojiClientError?) -> Void) {
    guard let client = KituraKit(baseURL: baseURL) else {
      return completion(nil, EmojiClientError.couldNotCreateClient)
    }
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    client.post("/entries", data: entry) { (savedEntry: JournalEntry?, error: RequestError?) in
      DispatchQueue.main.async {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let _ = error {
          return completion(nil, EmojiClientError.couldNotAdd(entry))
        }
        completion(savedEntry, nil)
      }
    }
  }
  
  static func delete(entry: JournalEntry, completion: @escaping (_ error: EmojiClientError?) -> Void) {
    guard let client = KituraKit(baseURL: baseURL) else {
      return completion(EmojiClientError.couldNotCreateClient)
    }
    guard let id = entry.id else {
      return completion(EmojiClientError.couldNotDelete(entry))
    }
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    client.delete("/entries", identifier: id) { (error) in
      DispatchQueue.main.async {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let _ = error {
          return completion(EmojiClientError.couldNotDelete(entry))
        }
        completion(nil)
      }
    }
  }
}
