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

public class SignUpUseCase: UseCase {
  let account: NewAccount
  let remoteAPI: AuthRemoteAPI
  let dataStore: UserSessionDataStore
  let actionDispatcher: ActionDispatcher

  public private(set) var userSession: UserSession?

  init(account: NewAccount,
       remoteAPI: AuthRemoteAPI,
       dataStore: UserSessionDataStore,
       actionDispatcher: ActionDispatcher) {
    self.account = account
    self.remoteAPI = remoteAPI
    self.dataStore = dataStore
    self.actionDispatcher = actionDispatcher
  }

  public func start() {
    remoteAPI.signUp(account: account)
      .then { userSession in
        self.userSession = userSession
        return Promise(value: userSession)
      }
      .then(execute: dataStore.save(userSession:))
      .then { userSession -> Void in
        let action = LoadedUserSessionAction(session: userSession)
        self.actionDispatcher.dispatch(action: action)
      }
      .catch { error in
        let errorMessage = ErrorMessage(title: "Sign Up Failed",
                                        message: "Could not sign up.\nPlease try again.")
        let action = OnboardingErrorOccuredAction(errorMessage: errorMessage)
        self.actionDispatcher.dispatch(action: action)
      }
  }
}
