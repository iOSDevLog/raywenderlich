/**
 * Copyright (c) 2018 Razeware LLC
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

class NumericalInputTextField: UITextField {
  // MARK: Variables
  @IBInspectable var max: Double = 1000.0

  // MARK: Initializers
  init(max: Double) {
    super.init(frame: .zero)
    self.max = max
    delegate = self
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    delegate = self
  }

  func flashBackground(withColor color: UIColor) {
    let originalBackgroudColor = backgroundColor
    let flashDuration: TimeInterval = 0.3
    UIView.animate(withDuration: flashDuration, animations: {
      self.backgroundColor = color
    }, completion: { _ in
      UIView.animate(withDuration: flashDuration) {
        self.backgroundColor = originalBackgroudColor
      }
    })
  }
}

// MARK: - UITextFieldDelegate

extension NumericalInputTextField: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    let textAfterChange = NSString(string: currentText).replacingCharacters(in: range, with: string)

    if let number = Double(textAfterChange) {
      if number <= max {
        return true
      } else {
        (textField as? NumericalInputTextField)?.flashBackground(withColor: .raspberryRed)
        return false
      }
    } else {
      return false
    }
  }

  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    // Prevent leaving the calories textField empty
    let text = textField.text ?? ""
    return !text.isEmpty
  }
}
