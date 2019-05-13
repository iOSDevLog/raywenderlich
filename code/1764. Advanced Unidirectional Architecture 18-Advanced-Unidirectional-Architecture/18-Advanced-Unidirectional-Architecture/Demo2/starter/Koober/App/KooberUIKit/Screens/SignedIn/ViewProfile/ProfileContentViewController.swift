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

import UIKit
import KooberKit
import RxSwift

public class ProfileContentViewController: NiblessViewController {
  // MARK: State
  let stateObservable: Observable<UserProfile>
  let disposeBag = DisposeBag()
  // MARK: Factories
  let useCaseFactory: ProfileUseCaseFactory

  init(stateObservable: Observable<UserProfile>,
       useCaseFactory: ProfileUseCaseFactory) {
    self.stateObservable = stateObservable
    self.useCaseFactory = useCaseFactory
    super.init()

    self.navigationItem.title = "My Profile"
    self.navigationItem.rightBarButtonItem =
      UIBarButtonItem(barButtonSystemItem: .done,
                      target: self,
                      action: #selector(ProfileContentViewController.close))
  }

  public override func loadView() {
    let rootView: ProfileContentRootView = {
      let view = ProfileContentRootView()
      view.ixResponder = self
      return view
    }()

    stateObservable.subscribe(onNext: { userProfile in
      rootView.update(state: userProfile)
    }).disposed(by: disposeBag)

    self.view = rootView
  }
}

extension ProfileContentViewController: ProfileIXResponder {
  @objc
  public func close() {
    useCaseFactory.makeCloseProfileUseCase().start()
  }

  public func signOut() {
    useCaseFactory.makeSignOutUseCase().start()
  }
}

protocol ProfileUseCaseFactory {
  func makeCloseProfileUseCase() -> UseCase
  func makeSignOutUseCase() -> UseCase
}
