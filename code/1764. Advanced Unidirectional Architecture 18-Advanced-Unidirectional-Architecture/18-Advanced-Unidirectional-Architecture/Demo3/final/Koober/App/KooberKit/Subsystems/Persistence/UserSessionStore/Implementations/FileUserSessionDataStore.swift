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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import PromiseKit

public class FileUserSessionDataStore: UserSessionDataStore {
  var docsURL: URL? {
    return FileManager
      .default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                    in: FileManager.SearchPathDomainMask.allDomainsMask).first
  }

  public init() {}

  public func readUserSession() -> Promise<UserSession?> {
    return Promise() { fulfill, reject in
      guard let docsURL = docsURL else {
        reject(KooberKitError.any)
        return
      }
      guard let jsonData = try? Data(contentsOf: docsURL.appendingPathComponent("user_session.json")) else {
        fulfill(nil)
        return
      }
      let decoder = JSONDecoder()
      let userSession = try! decoder.decode(UserSession.self, from: jsonData)
      fulfill(userSession)
    }
  }

  public func save(userSession: UserSession) -> Promise<(UserSession)> {
    return Promise() { fulfill, reject in
      let encoder = JSONEncoder()
      let jsonData = try! encoder.encode(userSession)

      guard let docsURL = docsURL else {
        reject(KooberKitError.any)
        return
      }
      try? jsonData.write(to: docsURL.appendingPathComponent("user_session.json"))
      fulfill(userSession)
    }
  }

  public func delete(userSession: UserSession) -> Promise<(UserSession)> {
    return Promise() { fulfill, reject in
      guard let docsURL = docsURL else {
        reject(KooberKitError.any)
        return
      }
      do {
        try FileManager.default.removeItem(at: docsURL.appendingPathComponent("user_session.json"))
      } catch {
        reject(KooberKitError.any)
        return
      }
      fulfill(userSession)
    }
  }
}
