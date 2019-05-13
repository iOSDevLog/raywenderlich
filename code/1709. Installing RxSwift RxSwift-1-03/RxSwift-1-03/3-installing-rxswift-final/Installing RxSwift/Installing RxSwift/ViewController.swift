//
//  ViewController.swift
//  Installing RxSwift
//
//  Created by Scott Gardner on 1/2/18.
//  Copyright © 2018 Scott Gardner. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    _ = Observable.of("Hello, RxSwift!")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

