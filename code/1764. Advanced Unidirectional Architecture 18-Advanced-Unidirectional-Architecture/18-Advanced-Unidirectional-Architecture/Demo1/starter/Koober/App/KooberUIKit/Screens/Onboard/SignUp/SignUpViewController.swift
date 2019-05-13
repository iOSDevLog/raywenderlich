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

public class SignUpViewController: NiblessViewController {
  // MARK: Factories
  let useCaseFactory: SignUpUseCaseFactory

  init(useCaseFactory: SignUpUseCaseFactory) {
    self.useCaseFactory = useCaseFactory
    super.init()
  }

  public override func loadView() {
    view = {
      let rootView = SignUpRootView()
      rootView.ixResponder = self
      return rootView
    }()
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addKeyboardObservers()
  }
  
  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    removeObservers()
  }
  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    (view as! SignUpRootView).configureViewAfterLayout()
  }
}

extension SignUpViewController: SignUpIXResponder {
  func signUp(account: NewAccount) {
    useCaseFactory.makeSignUpUseCase(account: account).start()
  }
}

protocol SignUpUseCaseFactory {
  func makeSignUpUseCase(account: NewAccount) -> UseCase
}

extension SignUpViewController {
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
          (view as! SignUpRootView).moveContentForDismissedKeyboard()
        } else {
          (view as! SignUpRootView).moveContent(forKeyboardFrame: convertedKeyboardEndFrame)
        }
    }
  }
}

