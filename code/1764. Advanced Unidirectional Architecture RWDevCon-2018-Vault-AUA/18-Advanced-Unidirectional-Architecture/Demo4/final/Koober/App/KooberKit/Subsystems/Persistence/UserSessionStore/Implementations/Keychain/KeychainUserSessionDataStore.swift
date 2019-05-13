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

public class KeychainUserSessionDataStore: UserSessionDataStore {
  let userSessionCoder: UserSessionCoding

  init(userSessionCoder: UserSessionCoding) {
    self.userSessionCoder = userSessionCoder
  }

  public func readUserSession() -> Promise<UserSession?> {
    return Promise<UserSession?> { fulfill, reject in
      DispatchQueue.global().async {
        self.readUserSessionSync(fulfill: fulfill, reject: reject)
      }
    }
  }

  public func save(userSession: UserSession) -> Promise<(UserSession)> {
    let data = userSessionCoder.encode(userSession: userSession)
    let item = KeychainItemWithData(data: data)
    return self.readUserSession()
                  .then { userSessionFromKeychain -> UserSession in
                    if userSessionFromKeychain == nil {
                      try Keychain.save(item: item)
                    } else {
                      try Keychain.update(item: item)
                    }
                    return userSession
                  }
  }

  public func delete(userSession: UserSession) -> Promise<(UserSession)> {
    return Promise<UserSession> { fulfill, reject in
      DispatchQueue.global().async {
        self.deleteSync(userSession: userSession, fulfill: fulfill, reject: reject)
      }
    }
  }
}

extension KeychainUserSessionDataStore {
  func readUserSessionSync(fulfill: (UserSession?) -> Void, reject: (Error) -> Void) {
    do {
      let query = KeychainItemQuery()
      if let data = try Keychain.findItem(query: query) {
        let userSession = self.userSessionCoder.decode(data: data)
        fulfill(userSession)
      } else {
        fulfill(nil)
      }
    } catch {
      reject(error)
    }
  }

  func deleteSync(userSession: UserSession, fulfill: (UserSession) -> Void, reject: (Error) -> Void) {
    do {
      let item = KeychainItem()
      try Keychain.delete(item: item)
      fulfill(userSession)
    } catch {
      reject(error)
    }
  }
}

enum KeychainUserSessionDataStoreError: Error {
  case typeCast
  case unknown
}
