//
//  DetailViewController.swift
//  PrettyIcons
//
//  Created by Brian on 10/9/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  var icon: Icon?
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let icon = icon else {
      return
    }
    
    if let iconImage = icon.image {
      imageView.image = iconImage
    }
    
  }

}
