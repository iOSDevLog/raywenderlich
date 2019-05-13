//
//  ViewController.swift
//  AgeChecker
//
//  Created by Brian on 9/21/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var age = 1;
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    age = lroundf(slider.value)
  }
  
  @IBAction func validateAge(_ sender: AnyObject) {
    if age >= 21 {
      print("\(age): Old enough.")
    } else {
      print("\(age): Too young!")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

