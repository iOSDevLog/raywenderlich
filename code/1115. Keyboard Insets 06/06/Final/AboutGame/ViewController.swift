/*
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

class ViewController: UIViewController {
  @IBOutlet weak var fgScrollView: UIScrollView!
  @IBOutlet weak var felipeImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // animate the wings
    var animationFrames = [UIImage]()
    for i in 0...3 {
      if let image = UIImage(named: "Bird\(i)") {
        animationFrames.append(image)
      }
    }

    felipeImageView.animationImages = animationFrames
    felipeImageView.animationDuration = 0.4
    felipeImageView.startAnimating()
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    adjustInsetForKeyboardShow(show: true, notification: notification)
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    adjustInsetForKeyboardShow(show: false, notification: notification)
  }
  
  func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
    let userInfo = notification.userInfo ?? [:]
    let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let adjustment = (keyboardFrame.height * (show ? 1 : -1)) + 20
    
    fgScrollView.contentInset.bottom += adjustment
    fgScrollView.scrollIndicatorInsets.bottom += adjustment
  }
  

}

extension ViewController: UIScrollViewDelegate {
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
