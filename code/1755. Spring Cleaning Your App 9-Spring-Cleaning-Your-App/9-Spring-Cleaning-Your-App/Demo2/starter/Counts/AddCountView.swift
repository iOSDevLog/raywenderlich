/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

protocol AddCountViewDelegate: class {
  func addCountView(_ view: AddCountView, didFinishCreating count: Count)
}

class AddCountView: UIView {

  // MARK: - Properties
  private let titleInput = UITextField()
  private let positiveSwitch = UISwitch()
  private let positiveLabel = UILabel()
  private let expandingView = UIView()
  private var expandedZeroHeightConstraint: NSLayoutConstraint!

  weak var delegate: AddCountViewDelegate?

  // MARK: - Initializers
  init(delegate: AddCountViewDelegate) {
    super.init(frame: .zero)

    addSubview(titleInput)
    self.delegate = delegate
    backgroundColor = UIColor(red: 1.0, green: 0.341, blue: 0.094, alpha: 1.0)

    titleInput.constrainToSuperview([.leading, .top, .trailing], insetBy: 16)
    titleInput.returnKeyType = .done
    titleInput.placeholder = "Add new Count"
    titleInput.delegate = self
    titleInput.tintColor = .white
    titleInput.textColor = .white

    addSubview(expandingView)
    expandingView.constrainToSuperview([.leading, .trailing, .bottom], insetBy: 16)
    expandingView.constrain(.top, to: titleInput, .bottom)
    expandedZeroHeightConstraint = expandingView.constrain(height: 0)
    expandingView.alpha = 0

    expandingView.addSubview(positiveSwitch)
    positiveSwitch.constrainToSuperview(.top, withOffset: 16)
    positiveSwitch.constrainToSuperview([.trailing, .bottom])
    positiveSwitch.isOn = false
    positiveSwitch.tintColor = .white

    expandingView.addSubview(positiveLabel)
    positiveLabel.constrainToSuperview(.leading)
    positiveLabel.constrain(.trailing, to: positiveSwitch, .leading, withOffset: -8)
    positiveLabel.constrain(to: positiveSwitch, edges: [.top, .bottom])

    positiveLabel.textAlignment = .right
    positiveLabel.text = "Count down"
    positiveLabel.textColor = .white
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UITextFieldDelegate
extension AddCountView: UITextFieldDelegate {

  func textFieldDidBeginEditing(_ textField: UITextField) {
    UIView.animate(withDuration: 0.2) {
      self.expandedZeroHeightConstraint.isActive = false
      self.expandingView.alpha = 1
      self.superview?.layoutIfNeeded()
    }
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    UIView.animate(withDuration: 0.2) {
      self.expandedZeroHeightConstraint.isActive = true
      self.expandingView.alpha = 0
      self.superview?.layoutIfNeeded()
    }
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let inputText = titleInput.text {
      let count = positiveSwitch.isOn ? 3 : 0
      let increment = positiveSwitch.isOn ? -1 : 1
      let request = Count(id: nil, title: inputText, count: count, total: 3, interval: .weekly, resetTime: nil, increment: increment)
      delegate?.addCountView(self, didFinishCreating: request)
      reset()
    }

    titleInput.resignFirstResponder()
    return true
  }

}

// MARK: - Private
private extension AddCountView {

  func reset() {
    titleInput.text = nil
    positiveSwitch.isOn = false
  }

}
