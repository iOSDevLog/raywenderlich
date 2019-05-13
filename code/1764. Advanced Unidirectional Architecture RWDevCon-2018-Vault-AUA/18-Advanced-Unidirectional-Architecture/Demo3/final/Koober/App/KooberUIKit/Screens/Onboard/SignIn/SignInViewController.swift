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
import PromiseKit
import RxSwift

public class SignInViewController : NiblessViewController, SignInIXResponder {
  // MARK: State
  let errorMessageObservable: Observable<ErrorMessage>
  let disposeBag = DisposeBag()
  // MARK: Factories
  let useCaseFactory: SignInUseCaseFactory

  init(useCaseFactory: SignInUseCaseFactory,
       errorMessageObservable: Observable<ErrorMessage>) {
    self.useCaseFactory = useCaseFactory
    self.errorMessageObservable = errorMessageObservable
    super.init()
  }

  public override func loadView() {
    self.view = {
      let view = SignInRootView()
      view.ixResponder = self
      return view
    }()
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    subscribe(to: errorMessageObservable)
  }

  func subscribe(to observable: Observable<ErrorMessage>) {
    observable.subscribe(onNext: { [weak self] errorMessage in
      guard let strongSelf = self else { return }
      strongSelf.on(next: errorMessage)
    }).disposed(by: disposeBag)
  }

  func on(next errorMessage: ErrorMessage) {
    let alert = UIAlertController(title: errorMessage.title,
                                  message: errorMessage.message,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true, completion: nil)
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addKeyboardObservers()
  }
  
  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    removeObservers()
  }

  func signIn(username: String, password: String) {
    useCaseFactory.makeSignInUseCase(username: username, password: password).start()
  }
  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    (view as! SignInRootView).configureViewAfterLayout()
  }
}

protocol SignInUseCaseFactory {
  func makeSignInUseCase(username: String, password: Secret) -> UseCase
}

extension SignInViewController {
  func addKeyboardObservers() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(handleContentUnderKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
    notificationCenter.addObserver(self, selector: #selector(handleContentUnderKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
  }
  
  func removeObservers() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.removeObserver(self)
  }
  
  @objc func handleContentUnderKeyboard(notification: Notification) {
    if let userInfo = notification.userInfo,
      let keyboardEndFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
      let convertedKeyboardEndFrame = view.convert(keyboardEndFrame.cgRectValue, from: view.window)
      if notification.name == Notification.Name.UIKeyboardWillHide {
        (view as! SignInRootView).moveContentForDismissedKeyboard()
      } else {
        (view as! SignInRootView).moveContent(forKeyboardFrame: convertedKeyboardEndFrame)
      }
    }
  }
}
