//
//  ViewController.swift
//  GuessANumber
//
//  Created by Brian on 9/23/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var randomNumber = 0
  
  @IBAction func guessNumber(_ sender: UIButton) {
    var message = ""
    if sender.tag == randomNumber {
      message = "Congrats, you guessed the number!"
    } else if sender.tag > randomNumber {
      message = "You guessed too high!"
    } else {
      message = "You guessed too low!"
    }
    
    let alertController = UIAlertController(title: "Guessing game", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(action)
    present(alertController, animated: true, completion: nil)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    randomNumber = Int(arc4random_uniform(10)) + 1
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

