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

public class SignedInViewController: NiblessViewController {
  // MARK: Child View Controllers
  let profileViewController: ProfileViewController
  var currentChildViewController: UIViewController?
  // MARK: State
  let userSession: UserSession
  let stateObservable: Observable<SignedInState>
  let screenObservable: Observable<SignedInScreen>
  let errorMessageObservable: Observable<ErrorMessage>
  let disposeBag = DisposeBag()
  // MARK: Factories
  let useCaseFactory: SignedInUseCaseFactory
  let viewControllerFactory: SignedInViewControllerFactory

  init(stateObservable: Observable<SignedInState>,
       screenObservable: Observable<SignedInScreen>,
       errorMessageObservable: Observable<ErrorMessage>,
       userSession: UserSession,
       profileViewController: ProfileViewController,
       useCaseFactory: SignedInUseCaseFactory,
       viewControllerFactory: SignedInViewControllerFactory) {
    self.stateObservable = stateObservable
    self.screenObservable = screenObservable
    self.errorMessageObservable = errorMessageObservable
    self.userSession = userSession
    self.profileViewController = profileViewController
    self.useCaseFactory = useCaseFactory
    self.viewControllerFactory = viewControllerFactory
    super.init()
  }

  public override func loadView() {
    view = {
      let view = SignedInRootView()
      view.ixResponder = self
      return view
    }()
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    subscribe(to: screenObservable)
    subscribe(to: stateObservable)
    subscribe(to: errorMessageObservable)
  }

  func subscribe(to screenObservable: Observable<SignedInScreen>) {
    screenObservable
      .subscribe(onNext: { [weak self] screen in
        guard let strongSelf = self else { return }
        strongSelf.on(next: screen)
      })
      .disposed(by: disposeBag)
  }

  func on(next screen: SignedInScreen) {
    switch screen {
    case .gettingUsersLocation:
      let viewController = viewControllerFactory.makeGettingUsersLocationViewController()
      transition(to: viewController)
    case .pickMeUp(let pickMeUpState):
      let viewController = viewControllerFactory
        .makePickMeUpViewController(pickupLocation: pickMeUpState.pickupLocation)
      transition(to: viewController)
    case .waitingForPickup:
      let viewController = viewControllerFactory.makeWaitingForPickupViewController()
      transition(to: viewController)
    }
  }

  func subscribe(to stateObservable: Observable<SignedInState>) {
    stateObservable.subscribe(onNext: { [weak self] state in
      guard let strongSelf = self else { return }
      strongSelf.on(next: state)
    }).disposed(by: disposeBag)
  }

  func on(next state: SignedInState) {
    if state.showingProfileScreen {
      if presentedViewController.isEmpty {
        present(profileViewController, animated: true)
      }
    } else {
      if profileViewController.view.window != nil {
        dismiss(animated: true)
      }
    }
  }

  func subscribe(to errorMessageObservable: Observable<ErrorMessage>) {
    errorMessageObservable
      .subscribe(onNext: { [weak self] errorMessage in
        guard let strongSelf = self else { return }
        strongSelf.on(next: errorMessage)
      })
      .disposed(by: disposeBag)
  }

  func on(next errorMessage: ErrorMessage) {
    let alert = UIAlertController(title: errorMessage.title,
                                  message: errorMessage.message,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true, completion: nil)
  }

  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    currentChildViewController?.view.frame = view.bounds
  }

  func transition(to viewController: UIViewController) {
    remove(childViewController: currentChildViewController)
    addFullScreen(childViewController: viewController)
    currentChildViewController = viewController
  }
}

extension SignedInViewController: SignedInIXResponder {
  func goToProfileScreen() {
    useCaseFactory.makeGoToProfileUseCase().start()
  }
}

protocol SignedInUseCaseFactory {
  func makeGoToProfileUseCase() -> UseCase
}

protocol SignedInViewControllerFactory {
  func makeGettingUsersLocationViewController() -> GettingUsersLocationViewController
  func makePickMeUpViewController(pickupLocation: Location) -> PickMeUpViewController
  func makeWaitingForPickupViewController() -> WaitingForPickupViewController
}
