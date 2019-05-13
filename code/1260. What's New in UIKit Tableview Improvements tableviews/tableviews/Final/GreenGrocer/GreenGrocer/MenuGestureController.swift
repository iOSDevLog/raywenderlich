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
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
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

class MenuGestureController: NSObject {
  
  var targetView: UIView!
  
  init(view: UIView) {
    targetView = view
    super.init()
    tapGestureRecognizer.delegate = self
  }
  
  public lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
    return UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
  }()
  
  public lazy var tapGestureRecognizer = {
    return UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
  }()
  
  @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
    switch sender.state {
    case .began:
      let pressLocation = sender.location(in: targetView)
      
      targetView.becomeFirstResponder()
      let menu = UIMenuController.shared
      let rect = CGRect(origin: pressLocation, size: CGSize(width: 10, height: 10))
      menu.setTargetRect(rect, in: targetView)
      menu.setMenuVisible(true, animated: true)
    case .cancelled:
      UIMenuController.shared.setMenuVisible(false, animated: true)
    default:
      return
    }
  }
  
  @objc func handleTap(sender: UITapGestureRecognizer) {
    UIMenuController.shared.setMenuVisible(false, animated: true)
  }
}

// MARK: UIGestureRecognizerDelegate
extension MenuGestureController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return UIMenuController.shared.isMenuVisible
  }
}

