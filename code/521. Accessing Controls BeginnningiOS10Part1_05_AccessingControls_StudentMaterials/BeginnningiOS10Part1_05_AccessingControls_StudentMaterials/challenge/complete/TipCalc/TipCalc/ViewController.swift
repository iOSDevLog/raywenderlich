//
//  ViewController.swift
//  TipCalc
//
//  Created by Brian on 9/21/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
  @IBOutlet weak var amount: UITextField!
  @IBOutlet weak var percentage: UITextField!
  @IBOutlet weak var result: UILabel!
  
  @IBAction func calcTip(_ sender: AnyObject) {
    guard let amountText = amount.text, let percentageText = percentage.text else { return }
    guard let amount = Float(amountText), let percentage = Float(percentageText) else { return }
    let tip = amount * percentage / 100
    result.text = "Your tip: \(tip)"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    amount.delegate = self
    percentage.delegate = self
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

