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

public class WelcomeRootView: NiblessView {
  var hierarchyNotReady = true
  weak var ixResponder: WelcomeIXResponder?

  let appLogoImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "roo_logo"))
    imageView.backgroundColor = Color.background
    return imageView
  }()
  let appNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 36)
    label.text = "KOOBER"
    label.textColor = UIColor.white
    return label
  }()
  let signInButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("Sign In", for: .normal)
    button.backgroundColor = Color.darkButtonBackground
    button.layer.cornerRadius = 3
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.heightAnchor
      .constraint(equalToConstant: 50)
      .isActive = true
    return button
  }()
  let signUpButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("Sign Up", for: .normal)
    button.backgroundColor = Color.background
    button.layer.cornerRadius = 3
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.white.cgColor
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.heightAnchor
      .constraint(equalToConstant: 50)
      .isActive = true
    return button
  }()
  lazy var buttonStackView: UIStackView = {
    let stackView =
      UIStackView(arrangedSubviews: [signInButton, signUpButton])
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .center
    stackView.spacing = 10
    return stackView
  }()

  public override func didMoveToWindow() {
    super.didMoveToWindow()
    guard hierarchyNotReady else {
      return
    }
    backgroundColor = Color.background
    constructHierarchy()
    activateConstraints()

    signInButton.addTarget(ixResponder,
                           action: #selector(WelcomeIXResponder.goToSignIn),
                           for: .touchUpInside)
    signUpButton.addTarget(ixResponder,
                           action: #selector(WelcomeIXResponder.goToSignUp),
                           for: .touchUpInside)
    hierarchyNotReady = false
  }

  func constructHierarchy() {
    addSubview(appLogoImageView)
    addSubview(buttonStackView)
  }

  func activateConstraints() {
    activateConstraintsAppLogo()
    activateConstraintsButtons()
  }

  func activateConstraintsAppLogo() {
    appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
    let centerY = appLogoImageView.centerYAnchor
      .constraint(equalTo: centerYAnchor)
    let centerX = appLogoImageView.centerXAnchor
      .constraint(equalTo: centerXAnchor)
    NSLayoutConstraint.activate([centerY, centerX])
  }
  
  func activateConstraintsAppNameLabel() {
    appNameLabel.translatesAutoresizingMaskIntoConstraints = false
    let centerX = appNameLabel.centerXAnchor
      .constraint(equalTo: appLogoImageView.centerXAnchor)
    let top = appNameLabel.topAnchor
      .constraint(equalTo: appLogoImageView.bottomAnchor, constant: 10)
    NSLayoutConstraint.activate([centerX, top])
  }

  func activateConstraintsButtons() {
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    let leading = buttonStackView.leadingAnchor
      .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    let trailing = buttonStackView.trailingAnchor
      .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    let bottom = buttonStackView.bottomAnchor
      .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30)
    let height = buttonStackView.heightAnchor
      .constraint(equalToConstant: 50)
    NSLayoutConstraint.activate([leading, trailing, bottom, height])
  }

}
