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

private let defaultInitialFruitCount = 5
private let maxFruitCount = 300.0

class FruitsInputViewController: UIViewController {
  @IBOutlet private weak var pickerView: UIPickerView!
  @IBOutlet private weak var countTextField: UITextField!
  @IBOutlet private weak var stepper: UIStepper!
  @IBOutlet private weak var caloriesCountLabel: UILabel!

  private var fruitsTableViewController: FruitsTableViewController!

  private var fruits = FruitStore.fruits.sorted { $0.name < $1.name }

  // Use stepper.value to store and retrieve the current number of fruits
  private var selectedFruitCount: Double {
    get {
      return stepper.value
    }
    set {
      stepper.value = newValue
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    selectedFruitCount = Double(defaultInitialFruitCount)
    stepperValueChanged(stepper)
    pickerView.selectRow(1, inComponent: 0, animated: false) // Select 2nd option
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Update fruits since calories may have changed in settings
    fruits = FruitStore.fruits.sorted { $0.name < $1.name }
    reloadData()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Obtain reference to embedded child view controller
    fruitsTableViewController = segue.destination as! FruitsTableViewController
  }

  private func reloadData() {
    let selectedRow = pickerView.selectedRow(inComponent: 0)
    let selectedFruit = FruitStore.fruits[selectedRow]
    let totalCalories = selectedFruit.calories * selectedFruitCount
    fruitsTableViewController.configure(calories: totalCalories)
    pickerView.reloadAllComponents()
    let containWord = (countTextField.text == "1") ? "Contains" : "Contain"
    caloriesCountLabel.text = "\(containWord) \(Int(totalCalories)) calories, eqivalent to:"
  }

  // MARK: - IBActions
  @IBAction private func stepperValueChanged(_ sender: UIStepper) {
    countTextField.text = Formatter.string(from: selectedFruitCount)
    reloadData()
  }

  @IBAction private func textFieldEditingChanged(_ sender: UITextField) {
    selectedFruitCount = Double(countTextField.text ?? "") ?? 0
    reloadData()
  }

  @IBAction func backgroundViewTapped(_ sender: UIControl) {
    // Dismiss keyboard
    view.endEditing(true)
  }
}

// MARK: - UIPickerViewDataSource
extension FruitsInputViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return fruits.count
  }
}

// MARK: - UIPickerViewDelegate
extension FruitsInputViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = (view as? UILabel) ?? UILabel()
    label.font = UIFont.systemFont(ofSize: 27)
    label.textColor = .white
    let fruit = fruits[row]
    let singularOrPluralFruitName = countTextField.text == "1" ? fruit.name : fruit.pluralizedName
    label.text = "\(fruit.emojiChar) \(singularOrPluralFruitName)"
    return label
  }

  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 40
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    reloadData()
  }
}

// MARK: - UITextFieldDelegate
extension FruitsInputViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)

    // Only allow doubles or empty string
    if let fruitCount = Double(updatedText) {
      return fruitCount <= maxFruitCount
    } else {
      return updatedText.isEmpty
    }
  }
}
