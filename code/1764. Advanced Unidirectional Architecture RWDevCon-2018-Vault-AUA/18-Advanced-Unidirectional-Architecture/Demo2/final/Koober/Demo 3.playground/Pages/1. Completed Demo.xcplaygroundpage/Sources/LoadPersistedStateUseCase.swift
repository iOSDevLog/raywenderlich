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

public class LoadPersistedStateUseCase: UseCase {
  let userStore: PersistentUserStore
  let reduxStore: Store<AppState>
  let statePersister: StatePersister

  public init(userStore: PersistentUserStore,
              reduxStore: Store<AppState>,
              statePersister: StatePersister) {
    self.userStore = userStore
    self.reduxStore = reduxStore
    self.statePersister = statePersister
  }

  public func start() {
    userStore.readUserProfile()
      .then(execute: dispatchLoadedAction(userProfile:))
      .then(execute: startPersistingStateChanges)
      .catch { error in }
  }

  func dispatchLoadedAction(userProfile: UserProfile) {
    let appState = AppState(userProfile)
    let action = LoadedPersistedState(appState: appState)
    reduxStore.dispatch(action)
  }

  func startPersistingStateChanges() {
    statePersister.startPersistingStateChanges(to: userStore)
  }
}
