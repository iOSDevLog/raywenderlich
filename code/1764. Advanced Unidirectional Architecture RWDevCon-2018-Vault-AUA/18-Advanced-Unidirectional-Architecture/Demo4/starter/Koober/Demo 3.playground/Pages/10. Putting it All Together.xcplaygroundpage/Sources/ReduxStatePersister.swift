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
import RxSwift
import ReSwift

public class ReduxStatePersister: StatePersister {
  let userProfileObservable: Observable<UserProfile>
  let disposeBag = DisposeBag()

  public init(reduxStore: Store<AppState>) {
    self.userProfileObservable = reduxStore
                                   .makeObservable(getUserProfile)
                                   .distinctUntilChanged()
                                   .skip(1)
  }

  public func startPersistingStateChanges(to userStore: PersistentUserStore) {
    userProfileObservable.subscribe(onNext: { [weak self] userProfile in
      self?.persist(userProfile, to: userStore)
    }).disposed(by: disposeBag)
  }

  func persist(_ userProfile: UserProfile, to userStore: PersistentUserStore) {
    userStore
      .save(userProfile: userProfile)
      .catch { error in fatalError("Handle Error") }
  }
}

private func getUserProfile(appState: AppState) -> UserProfile {
  return appState.settingsViewState.userProfile
}
