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

class WaitingForPickupRootView: NiblessView {
  weak var ixResponder: WaitingForPickupIXResponder?

  let successImageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "success_message"))
    return imageView
  }()
  
  let newRideButton: UIButton  = {
    let button = UIButton(type: .system)
    button.setTitle("Start New Ride", for: .normal)
    button.backgroundColor = Color.lightButtonBackground
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.setTitleColor(UIColor.white, for: UIControlState.normal)
    button.layer.cornerRadius = 3
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = Color.background
    addSubview(successImageView)
    addSubview(newRideButton)
    activateConstraintsSuccessImage()
    activateConstraintsNewRideButton()
    wireController()
  }

  func wireController() {
    newRideButton.addTarget(self, action: #selector(handleStartNewRideButtonTap), for: .touchUpInside)
  }
  
  func activateConstraintsSuccessImage() {
    successImageView.translatesAutoresizingMaskIntoConstraints = false
    let centerX = successImageView.centerXAnchor
      .constraint(equalTo: centerXAnchor)
    let centerY = successImageView.centerYAnchor
      .constraint(equalTo: centerYAnchor)
    NSLayoutConstraint.activate(
      [centerX, centerY])
  }
  
  func activateConstraintsNewRideButton() {
    newRideButton.translatesAutoresizingMaskIntoConstraints = false
    let leading = newRideButton.leadingAnchor
      .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    let trailing = newRideButton.trailingAnchor
      .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    let bottom = newRideButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
    let height = newRideButton.heightAnchor.constraint(equalToConstant: 50)
    NSLayoutConstraint.activate(
      [leading, trailing, bottom, height])
  }

  @objc
  func handleStartNewRideButtonTap() {
    ixResponder?.startNewRide()
  }
}
