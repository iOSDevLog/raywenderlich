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

public struct FakeAuthRemoteAPI: AuthRemoteAPI {
  public init() {}

  public func signIn(username: String, password: String) -> Promise<UserSession> {
    guard username == "johnny@gmail.com" && password == "password" else {
      return Promise(error: KooberKitError.any)
    }
    let profile = UserProfile(name: "Johnny Appleseed",
                              email: "johnny@gmail.com",
                              mobileNumber: "510-736-8754",
                              avatar: makeURL())
    let remoteUserSession = RemoteUserSession(token: "64652626")
    let userSession = UserSession(profile: profile, remoteSession: remoteUserSession)
    return Promise(value: userSession)
  }

  public func signUp(account: NewAccount) -> Promise<UserSession> {
    let profile = UserProfile(name: account.fullName,
                              email: account.email,
                              mobileNumber: account.mobileNumber,
                              avatar: makeURL())
    let remoteUserSession = RemoteUserSession(token: "984270985")
    let userSession = UserSession(profile: profile, remoteSession: remoteUserSession)
    return Promise(value: userSession)
  }
}
