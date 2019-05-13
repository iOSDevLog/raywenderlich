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
import ReSwift

class UpdateClawedUseCase: UseCase {
  // MARK: Input
  let clawed: Bool
  // MARK: Dependencies
  let remoteAPI: UserRemoteAPI
  let reduxStore: Store<AppState>

  init(clawed: Bool,
       remoteAPI: UserRemoteAPI,
       reduxStore: Store<AppState>) {
    self.clawed = clawed
    self.remoteAPI = remoteAPI
    self.reduxStore = reduxStore
  }

  func start() {
    remoteAPI.putUserProfile(clawed: clawed)
      .then(execute: dispatchUpdateAction(userProfile:))
      .catch { error in }
  }

  func dispatchUpdateAction(userProfile: UserProfile) {
    let action = UpdateClawed(userProfile: userProfile)
    self.reduxStore.dispatch(action)
  }
}
