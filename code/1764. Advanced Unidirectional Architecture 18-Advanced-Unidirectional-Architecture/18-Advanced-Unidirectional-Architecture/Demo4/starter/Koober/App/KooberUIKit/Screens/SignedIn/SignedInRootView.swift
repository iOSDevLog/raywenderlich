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

class SignedInRootView: NiblessView {
  weak var ixResponder: SignedInIXResponder?

  let goToProfileControl: UIButton = {
    let button = UIButton(type: .system)
    let profileIcon = #imageLiteral(resourceName: "person_icon")
      button.setImage(profileIcon, for: UIControlState.normal)
    button.tintColor = Color.darkTextColor
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = Color.background

    addSubview(goToProfileControl)
    goToProfileControl.addTarget(self, action: #selector(SignedInRootView.handleProfileControlTap), for: .touchUpInside)
  }

  override func didAddSubview(_ subview: UIView) {
    super.didAddSubview(subview)
    bringSubview(toFront: goToProfileControl)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    goToProfileControl.frame = CGRect(x: frame.maxX - 85, y: 24, width: 100, height: 50)
  }

  @objc
  func handleProfileControlTap() {
    ixResponder?.goToProfileScreen()
  }
}
