//
//  ViewController.swift
//  DemoAutoLayout
//
//  Created by Jerry Beers on 8/31/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var indentConstraint: NSLayoutConstraint!
  override func viewDidLoad() {
    super.viewDidLoad()

    indentConstraint.constant = 10
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

