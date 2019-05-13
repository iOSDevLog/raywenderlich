//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Brian on 9/23/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

  @IBAction func close() {
    dismiss(animated: true, completion: nil)
  }
  @IBOutlet weak var webView: UIWebView!
  
  
  
    override func viewDidLoad() {
      super.viewDidLoad()

      if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
        if let htmlData = try? Data(contentsOf: url) {
          let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
          webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
        }
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
