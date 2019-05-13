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
import KooberKit

class SignUpRootView: NiblessView {
  weak var ixResponder: SignUpIXResponder?

  var hierarchyNotReady = true

  var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()
  
  var contentView: UIView = {
    let contentView = UIView()
    return contentView
  }()
  
  lazy var inputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews:
      [fullNameInputStack,
       nicknameInputStack,
       emailInputStack,
       mobileNumberInputStack,
       passwordInputStack])
    stack.axis = .vertical
    stack.spacing = 10
    return stack
  }()

  lazy var fullNameInputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews:
      [fullNameIcon, fullNameField])
    stack.axis = .horizontal
    return stack
  }()
  let fullNameIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.heightAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.widthAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.image = #imageLiteral(resourceName: "person_icon")
    imageView.contentMode = .center
    return imageView
  }()
  let fullNameField: UITextField = {
    let field = UITextField()
    field.placeholder = "Full Name"
    field.backgroundColor = Color.background
    field.autocorrectionType = UITextAutocorrectionType.no
    field.autocapitalizationType = UITextAutocapitalizationType.words
    field.textColor = UIColor.white
    return field
  }()

  lazy var nicknameInputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews:
      [nicknameIcon, nicknameField])
    stack.axis = .horizontal
    return stack
  }()
  let nicknameIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.heightAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.widthAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.image = #imageLiteral(resourceName: "tag_icon")
    imageView.contentMode = .center
    return imageView
  }()
  let nicknameField: UITextField = {
    let field = UITextField()
    field.placeholder = "What should we call you?"
    field.backgroundColor = Color.background
    field.textColor = UIColor.white
    field.autocorrectionType = UITextAutocorrectionType.no
    field.autocapitalizationType = UITextAutocapitalizationType.words
    return field
  }()

  lazy var emailInputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews:
      [emailIcon, emailField])
    stack.axis = .horizontal
    return stack
  }()
  let emailIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.heightAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.widthAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.image = #imageLiteral(resourceName: "email_icon")
    imageView.contentMode = .center
    return imageView
  }()
  let emailField: UITextField = {
    let field = UITextField()
    field.placeholder = "Email"
    field.backgroundColor = Color.background
    field.textColor = UIColor.white
    field.keyboardType = UIKeyboardType.emailAddress
    field.autocapitalizationType = UITextAutocapitalizationType.none
    field.autocorrectionType = UITextAutocorrectionType.no
    return field
  }()

  lazy var mobileNumberInputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews:
      [mobileNumberIcon, mobileNumberField])
    stack.axis = .horizontal
    return stack
  }()
  let mobileNumberIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.heightAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.widthAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.image = #imageLiteral(resourceName: "mobile_icon")
    imageView.contentMode = .center
    return imageView
  }()
  let mobileNumberField: UITextField = {
    let field = UITextField()
    field.placeholder = "Mobile Number"
    field.backgroundColor = Color.background
    field.textColor = UIColor.white
    field.keyboardType = UIKeyboardType.phonePad
    field.autocapitalizationType = UITextAutocapitalizationType.none
    field.autocorrectionType = UITextAutocorrectionType.no
    return field
  }()

  lazy var passwordInputStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews:
      [passwordIcon, passwordField])
    stack.axis = .horizontal
    return stack
  }()
  let passwordIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.heightAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.widthAnchor
      .constraint(equalToConstant: 40)
      .isActive = true
    imageView.image = #imageLiteral(resourceName: "password_icon")
    imageView.contentMode = .center
    return imageView
  }()
  let passwordField: UITextField = {
    let field = UITextField()
    field.placeholder = "Password"
    field.backgroundColor = Color.background
    field.isSecureTextEntry = true
    field.textColor = UIColor.white
    return field
  }()

  let signUpButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("Sign Up", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.backgroundColor = Color.darkButtonBackground
    return button
  }()

  override func didMoveToWindow() {
    super.didMoveToWindow()
    guard hierarchyNotReady else {
      return
    }
    backgroundColor = Color.background
    constructHierarchy()
    activateConstraints()
    wireController()
    hierarchyNotReady = false
  }

  func constructHierarchy() {
    scrollView.addSubview(contentView)
    contentView.addSubview(inputStack)
    contentView.addSubview(signUpButton)
    addSubview(scrollView)
  }

  func activateConstraints() {
    activateConstraintsScrollView()
    activateConstraintsContentView()
    activateConstraintsInputStack()
    activateConstraintsSignUpButton()
  }

  func wireController() {
    signUpButton.addTarget(self, action: #selector(handleSignUpButtonTap), for: .touchUpInside)
  }

  @objc func handleSignUpButtonTap() {
    let account = NewAccount(fullName: fullNameField.text ?? "",
                             nickname: nicknameField.text ?? "",
                             email: emailField.text ?? "",
                             mobileNumber: mobileNumberField.text ?? "",
                             password: passwordField.text ?? "")
    ixResponder?.signUp(account: account)
  }

  func configureViewAfterLayout() {
    resetScrollViewContentInset()
  }
  
  func resetScrollViewContentInset() {
    let scrollViewBounds = scrollView.bounds
    let contentViewHeight = CGFloat(330.0)

    var scrollViewInsets = UIEdgeInsets.zero
    scrollViewInsets.top = scrollViewBounds.size.height / 2.0;
    scrollViewInsets.top -= contentViewHeight / 2.0;

    scrollViewInsets.bottom = scrollViewBounds.size.height / 2.0
    scrollViewInsets.bottom -= contentViewHeight / 2.0

    scrollView.contentInset = scrollViewInsets
  }
  
  func activateConstraintsScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    let leading = scrollView.leadingAnchor
      .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    let trailing = scrollView.trailingAnchor
      .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    let top = scrollView.topAnchor
      .constraint(equalTo: safeAreaLayoutGuide.topAnchor)
    let bottom = scrollView.bottomAnchor
      .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    NSLayoutConstraint.activate(
      [leading, trailing, top, bottom])
  }
  
  func activateConstraintsContentView() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    let width = contentView.widthAnchor
      .constraint(equalTo: scrollView.widthAnchor)
    let leading = contentView.leadingAnchor
      .constraint(equalTo: scrollView.leadingAnchor)
    let trailing = contentView.trailingAnchor
      .constraint(equalTo: scrollView.trailingAnchor)
    let top = contentView.topAnchor
      .constraint(equalTo: scrollView.topAnchor)
    let bottom = contentView.bottomAnchor
      .constraint(equalTo: scrollView.bottomAnchor)
    NSLayoutConstraint.activate(
      [width, leading, trailing, top, bottom])
  }
  
  func activateConstraintsInputStack() {
    inputStack.translatesAutoresizingMaskIntoConstraints = false
    let leading = inputStack.leadingAnchor
      .constraint(equalTo: contentView.leadingAnchor)
    let trailing = inputStack.trailingAnchor
      .constraint(equalTo: contentView.trailingAnchor)
    let top = inputStack.topAnchor
      .constraint(equalTo: contentView.topAnchor)
    NSLayoutConstraint.activate(
      [leading, trailing, top])
  }

  func activateConstraintsSignUpButton() {
    signUpButton.translatesAutoresizingMaskIntoConstraints = false
    let leading = signUpButton.leadingAnchor
      .constraint(equalTo: contentView.leadingAnchor)
    let trailing = signUpButton.trailingAnchor
      .constraint(equalTo: contentView.trailingAnchor)
    let top = signUpButton.topAnchor
      .constraint(equalTo: inputStack.bottomAnchor, constant: 20)
    let bottom = signUpButton.bottomAnchor
      .constraint(equalTo: contentView.bottomAnchor, constant: -20)
    let height = signUpButton.heightAnchor
      .constraint(equalToConstant: 50)
    NSLayoutConstraint.activate(
      [leading, trailing, top, bottom, height])
  }
  
  func moveContentForDismissedKeyboard() {
    resetScrollViewContentInset()
  }
  
  func moveContent(forKeyboardFrame keyboardFrame: CGRect) {
    var insets = scrollView.contentInset
    insets.bottom = keyboardFrame.height
    scrollView.contentInset = insets
  }
  
}
