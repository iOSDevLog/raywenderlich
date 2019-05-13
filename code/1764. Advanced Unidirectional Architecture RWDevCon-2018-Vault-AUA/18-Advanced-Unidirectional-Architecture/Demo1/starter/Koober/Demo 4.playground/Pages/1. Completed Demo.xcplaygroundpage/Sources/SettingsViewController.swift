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

public class SettingsViewController: NiblessViewController {
  let stateObservable: Observable<SettingsViewState>
  let disposeBag = DisposeBag()
  let loadUserProfileUseCaseFactory: LoadUserProfileUseCaseFactory
  let updateClawedUseCaseFactory: UpdateClawedUseCaseFactory // New

  var rootView: SettingsRootView {
    return view as! SettingsRootView
  }

  init(stateObservable: Observable<SettingsViewState>,
       loadUserProfileUseCaseFactory: LoadUserProfileUseCaseFactory,
       updateClawedUseCaseFactory: UpdateClawedUseCaseFactory) { // New
    self.stateObservable = stateObservable
    self.loadUserProfileUseCaseFactory = loadUserProfileUseCaseFactory
    self.updateClawedUseCaseFactory = updateClawedUseCaseFactory // New
    super.init()
  }

  public override func loadView() {
    view = SettingsRootView(ixResponder: self)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    subscribe(to: stateObservable)
  }

  func subscribe(to observable: Observable<SettingsViewState>) {
    observable.subscribe(
      onNext: { [weak self] viewModel in
        self?.updateView(withViewModel: viewModel)
      }, onError: { [weak self] error in
        self?.handle(stateError: error)
    }).disposed(by: disposeBag)
  }

  func updateView(withViewModel viewModel: SettingsViewState) {
    rootView.update(with: viewModel)
  }

  func handle(stateError error: Error) {
    print("Handle error by for example displaying an error message or screen.")
  }
}

extension SettingsViewController: SettingsIXResponder {
  public func loadUserProfile() {
    let useCase = loadUserProfileUseCaseFactory.makeLoadUserProfileUseCase()
    useCase.start()
  }

  public func update(clawed: Bool) { // New
    let useCase = updateClawedUseCaseFactory.makeUpdateClawedUseCase(clawed: clawed)
    useCase.start()
  }
}
