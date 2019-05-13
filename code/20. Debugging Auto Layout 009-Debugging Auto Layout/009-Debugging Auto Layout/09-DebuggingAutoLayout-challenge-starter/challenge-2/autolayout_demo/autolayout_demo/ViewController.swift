//
//  ViewController.swift
//  AutoLayout_Demo
//
//  Created by Brian Moakley on 1/29/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var name: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    name.text = "Hubert Blaine Wolfeschlegelsteinhausenbergerdorff"
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

