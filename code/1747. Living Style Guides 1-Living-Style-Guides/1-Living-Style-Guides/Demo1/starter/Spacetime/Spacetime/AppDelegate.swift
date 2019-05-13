//
//  AppDelegate.swift
//  Spacetime
//
//  Created by Ellen Shapiro on 10/22/17.
//  Copyright © 2017 RayWenderlich.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func applicationDidFinishLaunching(_ application: UIApplication) {
    self.setupAppearanceProxies()
  }
  
  private func setupAppearanceProxies() {
    let blue = UIColor.spc_from(r: 9, g: 51, b: 119)
    UITabBar.appearance().tintColor = blue
    UITabBarItem.appearance().setTitleTextAttributes([
      .font: UIFont.spc_standard(size: 10),
      ], for: .normal)
    
    UINavigationBar.appearance().barTintColor = blue
    UINavigationBar.appearance().titleTextAttributes = [
      .foregroundColor: UIColor.white,
      .font: UIFont.spc_bold(size: 17),
    ]
    
    UIBarButtonItem.appearance().tintColor = .white
    UIBarButtonItem.appearance().setTitleTextAttributes([
      .font: UIFont.spc_standard(size: 16),
    ], for: .normal)
  }
}
