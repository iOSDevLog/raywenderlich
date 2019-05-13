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

private let defaultInitialCalories = 500.0
private let maxCalories = 2000.0

class CaloriesInputViewController: UIViewController {

  private var fruitsTableViewController: FruitsTableViewController!

  @IBOutlet weak var caloriesTextField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()

    caloriesTextField.text = Formatter.string(from: defaultInitialCalories)
    reloadData()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Obtain reference to embedded child view controller
    fruitsTableViewController = segue.destination as! FruitsTableViewController
  }

  private func reloadData() {
    let textFieldCalories = Double(caloriesTextField.text ?? "") ?? 0
    fruitsTableViewController.configure(calories: textFieldCalories)
  }

  private func flashBackground(of view: UIView, with color: UIColor) {
    UIView.animate(withDuration: 0.2, animations: {
      view.backgroundColor = color
    }, completion: { _ in
      UIView.animate(withDuration: 0.2) {
        view.backgroundColor = nil
      }
    })
  }

  // MARK: - IBActions
  @IBAction func textFieldEditingChanged(_ sender: UITextField) {
    reloadData()
  }

  @IBAction func backgroundViewTapped(_ sender: UIControl) {
    // Dismiss keyboard
    view.endEditing(true)
  }
}

// MARK: - UITextFieldDelegate
extension CaloriesInputViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)

    if let calories = Double(updatedText) {
      if calories <= maxCalories {
        return true
      } else {
        flashBackground(of: textField, with: .red)
        return false
      }
    } else {
      return updatedText.isEmpty
    }
  }
}
