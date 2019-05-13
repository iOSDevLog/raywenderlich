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
import  MobileCoreServices

class AddItemViewController: UIViewController {
  @IBOutlet weak var itemTextField: UITextField!
  weak var delegate: ListControllerProtocol?
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var productImageView: UIImageView!
  var gestureManager: MenuGestureController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pasteConfiguration = UIPasteConfiguration(acceptableTypeIdentifiers: [Product.productTypeId])
    setupGestureRecognizer()
    configureAccessibility()
    
    itemTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    itemTextField.becomeFirstResponder()
  }
  
  override func paste(itemProviders: [NSItemProvider]) {
    // 1
    itemProviders.forEach {
      $0.loadObject(ofClass: Product.self) { object, _ in
        guard let product = object as? Product else { return }
        let productImage = UIImage(named: product.photoName)
        
        DispatchQueue.main.async { [weak self] in
          guard let `self` = self else { return }
          self.itemTextField.text = product.name
          self.productImageView.image = productImage
        }
      }
    }
  }
  
  func setupGestureRecognizer() {
    gestureManager = MenuGestureController(view: view)
    if let gestureManager = gestureManager {
      view.addGestureRecognizer(gestureManager.longPressGestureRecognizer)
      view.addGestureRecognizer(gestureManager.tapGestureRecognizer)
    }
  }
  
  func configureAccessibility() {
    addButton.accessibilityLabel = "Add"
    addButton.accessibilityHint = "Add item to shopping list"
    
    cancelButton.accessibilityLabel = "Cancel"
    cancelButton.accessibilityHint = "Close without adding the item"
  }
  
  @IBAction func cancelButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addItemPressed(_ sender: Any) {
    if let text = itemTextField.text {
      delegate?.addItem(named: text)
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    addButton.accessibilityValue = textField.text
  }
  
}
