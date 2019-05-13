//
//  ViewController.swift
//  RWDevConRegistration
//
//  Created by Brian on 2/16/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  
  @objc func adjustInsetForKeyboard(_ notification: NSNotification) {
    guard let userInfo = notification.userInfo else { return }
    let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
    let show = (notification.name == UIResponder.keyboardWillShowNotification)
      ? true
      : false
    
    let adjustmentHeight = keyboardFrame.height  * (show ? 1 : -1)
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameTextField.delegate = self
    emailTextField.delegate = self

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(adjustInsetForKeyboard(_:)),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(adjustInsetForKeyboard(_:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil)
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
