//
//  ViewController.swift
//  EmbeddedWeb
//
//  Created by Brian on 9/23/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var webView: UIWebView!
  var sites = ["https://www.raywenderlich.com", "https://www.google.com"]

  override func viewDidLoad() {
    super.viewDidLoad()
    loadWebAddress(sites[0])
  }
  
  @IBAction func siteChanged(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex < sites.count {
      loadWebAddress(sites[sender.selectedSegmentIndex])
    }
  }
  
  func loadWebAddress(_ address: String) {
    guard let url = URL(string: address) else { return }
    let request = URLRequest(url: url)
    webView.loadRequest(request)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

