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

public class FakeUserSessionDataStore: UserSessionDataStore {
  public func save(userSession: UserSession) -> Promise<(UserSession)> {
    return Promise(value: userSession)
  }

  public func delete(userSession: UserSession) -> Promise<(UserSession)> {
    return Promise(value: userSession)
  }

  let hasToken: Bool

  init(hasToken: Bool) {
    self.hasToken = hasToken
  }

  public func readUserSession() -> Promise<UserSession?> {
    switch hasToken {
    case true:
      return runHasToken()
    case false:
      return runDoesNotHaveToken()
    }
  }

  public func runHasToken() -> Promise<UserSession?> {
    print("Try to read user session from fake disk...")
    print("  simulating having user session with token 4321...")
    print("  returning user session with token 4321...")
    let profile = UserProfile(name: "", email: "", mobileNumber: "", avatar: makeURL())
    let remoteSession = RemoteUserSession(token: "1234")
    return Promise(value: UserSession(profile: profile, remoteSession: remoteSession))
  }

  func runDoesNotHaveToken() -> Promise<UserSession?> {
    print("Try to read user session from fake disk...")
    print("  simulating empty disk...")
    print("  returning nil...")
    return Promise(value: nil)
  }
}
