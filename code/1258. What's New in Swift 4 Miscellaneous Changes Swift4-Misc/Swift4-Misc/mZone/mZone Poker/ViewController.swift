/**
 * Copyright (c) 2016 Razeware LLC
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

class ViewController: UIViewController {
  
  @IBOutlet weak var chipCountTextfield: UITextField!
  @IBOutlet weak var bigBlindTextfield: UITextField!
  @IBOutlet weak var chipCountLabel: UILabel!
  @IBOutlet weak var bigBlindLabel: UILabel!
  @IBOutlet weak var recommendationButton: UIButton!
  @IBOutlet weak var holderView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setLabels()
    setRoundedCorners()
    chipCountTextfield.becomeFirstResponder()
  }
  
  func setLabels() {
    chipCountLabel.text = NSLocalizedString("CHIP COUNT", comment: "")
    bigBlindLabel.text = NSLocalizedString("BIG BLIND", comment: "")
    recommendationButton.setTitle(NSLocalizedString("WHAT SHOULD I DO?", comment: ""), for: .normal)
  }
  
  func setRoundedCorners() {
    recommendationButton.layer.cornerRadius = 3.0
    holderView.layer.cornerRadius = 3.0
  }
  
  @IBAction func displayRecommendedAction(_ sender: UIButton) {

    if (chipCountTextfield.text!.characters.count == 0) {
      displayMessage(NSLocalizedString("Please enter your chip count", comment: ""),
        title: NSLocalizedString("Action Required", comment: ""))
      return
    }
    if (bigBlindTextfield.text!.characters.count == 0) {
      displayMessage(NSLocalizedString("Please enter the big blind amount", comment: ""),
        title: NSLocalizedString("Action Required", comment: ""))
      return
    }
    
    guard let chipCountValue = Int(chipCountTextfield.text!) else { return }
    guard let bigBlindValue = Int(bigBlindTextfield.text!) else { return }
    let totalBlindValue = bigBlindValue + (bigBlindValue / 2)
    let mValue = chipCountValue / totalBlindValue
    
    if (mValue > 6) {
      displayMessage(NSLocalizedString("You can wait for better cards", comment: ""),
        title: NSLocalizedString("Recommendation", comment: ""))
    } else {
      displayMessage(NSLocalizedString("Go all in", comment: ""),
        title: NSLocalizedString("Recommendation", comment: ""))
    }
    for textField in (holderView.subviews.filter {$0 is UITextField}) as! [UITextField] {
      textField.text = nil
    }
  }
  
  func displayMessage(_ message: String, title: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { (action) in }
    alertController.addAction(cancelAction)
    present(alertController, animated: true, completion: nil)
  }
  
  @IBAction func backgroundTapped(_ sender: Any) {
    view.endEditing(true)
  }
}
