//
//  DetailViewController.swift
//  CollectionView
//
//  Created by Brian on 7/16/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  var selection: String!
  @IBOutlet private weak var detailsLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    detailsLabel.text = selection

  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
