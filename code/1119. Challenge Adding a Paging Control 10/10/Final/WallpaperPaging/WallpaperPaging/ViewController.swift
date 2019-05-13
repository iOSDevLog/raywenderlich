//
//  ViewController.swift
//  WallpaperPaging
//
//  Created by Brian on 2/17/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

enum WallpaperConstants {
  static let wallpaperCount = 12
}

class ViewController: UIViewController {

  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var scrollView: UIScrollView!
  var pages: [WallpaperViewController] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pageControl.numberOfPages = WallpaperConstants.wallpaperCount
    var views: [String: UIView] = [:]
    views["view"] = view
    for i in 1...WallpaperConstants.wallpaperCount {
      let fileName = String(format: "%02d.jpg", i)
      let wallpaperController = createWallpaper(withFileName: fileName)
      pages.append(wallpaperController)
      views["page\(i)"] = wallpaperController.view
    }
    scrollView.isPagingEnabled = true
    addConstraints(withViews: views)
    scrollView.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  private func addConstraints(withViews views: [String: UIView]) {
    let verticalConstraints =
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|[page1(==view)]|", options: [], metrics: nil, views: views)
    NSLayoutConstraint.activate(verticalConstraints)
    var wallpaperConstraints = ""
    
    for i in 1...WallpaperConstants.wallpaperCount {
      wallpaperConstraints += "[page\(i)(==view)]"
    }
    let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|\(wallpaperConstraints)|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
    NSLayoutConstraint.activate(horizontalConstraints)
  }
  
  private func createWallpaper(withFileName backgroundImageName: String) -> WallpaperViewController {
    let wallpaper = storyboard!.instantiateViewController(withIdentifier: "WallpaperViewController") as! WallpaperViewController
    wallpaper.wallpaperImage = UIImage(named: backgroundImageName)
    wallpaper.view.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(wallpaper.view)
    
    addChildViewController(wallpaper)
    wallpaper.didMove(toParentViewController: self)
    
    return wallpaper
  }
}

extension ViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageWidth = scrollView.bounds.width
    let pageFraction = scrollView.contentOffset.x / pageWidth
    pageControl.currentPage = Int(round(pageFraction))
  }
}














