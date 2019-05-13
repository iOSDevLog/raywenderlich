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

class PickMeUpRootView: NiblessView {
  weak var ixResponder: PickMeUpIXResponder?
  let whereToButton: UIButton = {
    let button = UIButton(type: UIButtonType.system)
    button.setTitle("Where to?", for: .normal)
    button.backgroundColor = .white
    button.setTitleColor(Color.darkTextColor, for: UIControlState.normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
    button.layer.shadowRadius = 10.0
    button.layer.shadowOffset = CGSize(width: 0, height: 2)
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.5
    return button
  }()

  @objc
  func handleWhereToTap() {
    ixResponder?.selectWhereTo()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(whereToButton)
    whereToButton.addTarget(self, action: #selector(PickMeUpRootView.handleWhereToTap), for: .touchUpInside)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let width = bounds.width
    let buttonMargin = CGFloat(50.0)
    let buttonWidth = width - buttonMargin * 2.0
    whereToButton.frame = CGRect(x: 50, y: 100, width: buttonWidth, height: 50)
    whereToButton.layer.shadowPath = UIBezierPath(rect: whereToButton.bounds).cgPath
  }
  
  override func didAddSubview(_ subview: UIView) {
    super.didAddSubview(subview)
    bringSubview(toFront: whereToButton)
  }
}

extension PickMeUpRootView: PickMeUpUserInterface {
  func dismissWhereToControl() {
    whereToButton.removeFromSuperview()
  }
  func presentWhereToControl() {
    addSubview(whereToButton)
  }
}
