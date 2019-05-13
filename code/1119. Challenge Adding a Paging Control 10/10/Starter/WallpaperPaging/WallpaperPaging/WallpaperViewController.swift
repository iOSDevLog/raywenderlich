//
//  WallpaperViewController.swift
//  WallpaperPaging
//
//  Created by Brian on 2/17/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class WallpaperViewController: UIViewController {


  @IBOutlet weak var wallpaperImageView: UIImageView!
  var wallpaperImage: UIImage?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    wallpaperImageView.image = wallpaperImage
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }


}
