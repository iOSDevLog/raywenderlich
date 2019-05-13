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

class SendingRideRquestRootView: NiblessView {
  var hierarchyNotReady = true
  
  lazy var requestStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews:
      [requestImageView,
       requestLabel])
    stack.axis = .vertical
    stack.spacing = 20
    return stack
  }()
  
  let requestLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 26)
    label.text = "Requesting Ride..."
    label.textColor = Color.darkTextColor
    label.textAlignment = .center
    return label
  }()
  
  let requestImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "requesting_indicator")
    imageView.contentMode = .center
    return imageView
  }()
  
  override func didMoveToWindow() {
    super.didMoveToWindow()
    guard hierarchyNotReady else {
      return
    }
    backgroundColor = UIColor.white
    constructHierarchy()
    activateConstraints()
    hierarchyNotReady = false
  }
  
  func constructHierarchy() {
    addSubview(requestStack)
  }
  
  func activateConstraints() {
    activateConstraintsRequestStack()
  }
  
  func activateConstraintsRequestStack() {
    requestStack.translatesAutoresizingMaskIntoConstraints = false
    let centerY = requestStack.centerYAnchor
      .constraint(equalTo: centerYAnchor)
    let centerX = requestStack.centerXAnchor
      .constraint(equalTo: centerXAnchor)
    NSLayoutConstraint.activate([centerY, centerX])
  }
}
