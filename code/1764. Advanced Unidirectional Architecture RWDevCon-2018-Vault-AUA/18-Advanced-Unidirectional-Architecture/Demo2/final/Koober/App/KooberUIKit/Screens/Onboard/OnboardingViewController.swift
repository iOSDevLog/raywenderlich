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

public class OnboardingViewController: NiblessViewController {
  // MARK: Child View Controllers
  let welcomeViewController: WelcomeViewController
  let signInViewController: SignInViewController
  let signUpViewController: SignUpViewController
  var currentViewController: UIViewController?
  // MARK: State
  let stateObservable: Observable<OnboardingScreen>
  let disposeBag = DisposeBag()

  init(stateObservable: Observable<OnboardingScreen>,
       welcomeViewController: WelcomeViewController,
       signInViewController: SignInViewController,
       signUpViewController: SignUpViewController) {
    self.welcomeViewController = welcomeViewController
    self.signInViewController = signInViewController
    self.signUpViewController = signUpViewController
    self.stateObservable = stateObservable
    super.init()
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    subscribe(to: stateObservable)
  }

  func subscribe(to observable: Observable<OnboardingScreen>) {
    observable.subscribe(onNext: { [weak self] screen in
      guard let strongSelf = self else { return }
      strongSelf.on(next: screen)
    }).disposed(by: disposeBag)
  }

  func on(next screen: OnboardingScreen) {
    switch screen {
    case .welcome:
      presentWelcome()
    case .signin:
      presentSignIn()
    case .signup:
      presentSignUp()
    }
  }

  func presentWelcome() {
    if let child = currentViewController {
      remove(childViewController: child)
    }
    addFullScreen(childViewController: welcomeViewController)
    currentViewController = welcomeViewController
  }

  func presentSignIn() {
    if let child = currentViewController {
      remove(childViewController: child)
    }
    addFullScreen(childViewController: signInViewController)
    currentViewController = signInViewController
  }

  func presentSignUp() {
    if let child = currentViewController {
      remove(childViewController: child)
    }
    addFullScreen(childViewController: signUpViewController)
    currentViewController = signUpViewController
  }
}
