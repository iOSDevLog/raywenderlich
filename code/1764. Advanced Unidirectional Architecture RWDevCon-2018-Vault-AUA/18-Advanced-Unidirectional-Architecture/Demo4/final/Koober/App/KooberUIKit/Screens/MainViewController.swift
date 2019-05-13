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
import PromiseKit
import KooberKit
import RxSwift

public class MainViewController: UIViewController {
  // MARK: Child View Controllers
  let launchViewController: LaunchViewController
  var signedInViewController: SignedInViewController?
  var onboardingViewController: OnboardingViewController?
  // MARK: State
  let rootScreenStateObservable: Observable<RootScreen>
  let disposeBag = DisposeBag()
  // MARK: Factories
  let viewControllerFactory: MainViewControllerFactory

  public init(rootScreenStateObservable: Observable<RootScreen>,
              launchViewController: LaunchViewController,
              viewControllerFactory: MainViewControllerFactory) {
    self.rootScreenStateObservable = rootScreenStateObservable
    self.launchViewController = launchViewController
    self.viewControllerFactory = viewControllerFactory
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable, message: "nope.")
  public required init?(coder aDecoder: NSCoder) {
    fatalError("Loading \(String(describing: MainViewController.self)) from a nib is unsupported in favor of initializer dependency injection.")
  }

  func subscribe(to observable: Observable<RootScreen>) {
    observable
      .subscribe(onNext: { [weak self] rootScreen in
        guard let strongSelf = self else { return }
        strongSelf.on(next: rootScreen)
      })
      .disposed(by: disposeBag)
  }

  func on(next rootScreen: RootScreen) {
    switch rootScreen {
    case .launching:
      let _ = presentLaunching()
    case .onboarding:
      if onboardingViewController?.presentingViewController == nil {
        if presentedViewController.exists {
          // Dismiss profile modal when signing out.
          dismiss(animated: true) { [weak self] in
            self?.presentOnboarding()
          }
        } else {
          presentOnboarding()
        }
      }
    case .signedIn(let signedInState):
      let _ = presentSignedIn(userSession: signedInState.userSession)
    }
  }

  public func presentLaunching() {
    addFullScreen(childViewController: launchViewController)
  }

  public func presentOnboarding() {
    let onboardingViewController = viewControllerFactory.makeOnboardingViewController()
    present(onboardingViewController, animated: true) {
      self.remove(childViewController: self.launchViewController)
      if let signedInViewController = self.signedInViewController {
        self.remove(childViewController: signedInViewController)
        self.signedInViewController = nil
      }
    }
    self.onboardingViewController = onboardingViewController
  }

  public func presentSignedIn(userSession: UserSession) {
    remove(childViewController: launchViewController)

    let signedInViewControllerToPresent: SignedInViewController
    if let vc = self.signedInViewController {
      signedInViewControllerToPresent = vc
    } else {
      signedInViewControllerToPresent = viewControllerFactory.makeSignedInViewController(session: userSession)
      self.signedInViewController = signedInViewControllerToPresent
    }

    addFullScreen(childViewController: signedInViewControllerToPresent)

    if onboardingViewController?.presentingViewController != nil {
      onboardingViewController = nil
      dismiss(animated: true)
    }
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    presentLaunching()

    subscribe(to: rootScreenStateObservable)
  }

  public override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

public protocol MainViewControllerFactory {
  func makeOnboardingViewController() -> OnboardingViewController
  func makeSignedInViewController(session: UserSession) -> SignedInViewController
}
