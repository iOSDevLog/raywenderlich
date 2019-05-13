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
import UIKit
import RxSwift
import ReSwift

class DependencyContainer: DependencyProvider {
  let reduxStore: Store<AppState> = Store(reducer: reduce, state: nil)
  let userStore: PersistentUserStore = FakePersistentUserStore()
  let statePersister: StatePersister

  init() {
    statePersister = ReduxStatePersister(reduxStore: reduxStore)
  }

  func makeSettingsViewController() -> UIViewController {
    let observable = makeSettingsViewStateObservable()
    return SettingsViewController(stateObservable: observable,
                                  loadUserProfileUseCaseFactory: self,
                                  updateClawedUseCaseFactory: self) // New
  }

  func makeSettingsViewStateObservable() -> Observable<SettingsViewState> {
    let observable =
      reduxStore
        .makeObservable { appState in
          return appState.settingsViewState
        }.distinctUntilChanged()
    return observable
  }

  func makeLoadPersistedStateUseCase() -> UseCase {
    return LoadPersistedStateUseCase(userStore: userStore,
                                     reduxStore: reduxStore,
                                     statePersister: statePersister)
  }

  func makeLoadUserProfileUseCase() -> UseCase {
    let remoteAPI = makeUserRemoteAPI()
    return LoadUserProfileUseCase(remoteAPI: remoteAPI,
                                  reduxStore: reduxStore)
  }

  func makeUpdateClawedUseCase(clawed: Bool) -> UseCase { // New
    let userRemoteAPI = makeUserRemoteAPI()
    return UpdateClawedUseCase(clawed: clawed,
                               remoteAPI: userRemoteAPI,
                               reduxStore: reduxStore)
  }

  func makeUserRemoteAPI() -> UserRemoteAPI {
    return KooberUserRemoteAPI()
  }
}
