//
//  ViewController.swift
//  AutoLayoutScrollViews
//
//  Created by Brian on 2/19/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    textView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

