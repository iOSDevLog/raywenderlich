//
//  AppDelegate.swift
//  Spacetime
//
//  Created by Ellen Shapiro on 10/22/17.
//  Copyright © 2017 RayWenderlich.com. All rights reserved.
//

import UIKit
import SpacetimeUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func applicationDidFinishLaunching(_ application: UIApplication) {
    self.setupAppearanceProxies()
  }
  
  private func setupAppearanceProxies() {
    UITabBar.appearance().tintColor = SpacetimeColor.tabBarContent.color
    UITabBarItem.appearance().setTitleTextAttributes([
      .font: UIFont.spc_standard(size: 10),
      ], for: .normal)
    
    UINavigationBar.appearance().barTintColor = SpacetimeColor.navigationBarBackground.color
    UINavigationBar.appearance().titleTextAttributes = [
      .foregroundColor: UIColor.white,
      .font: SpacetimeFont.bold.of(size: .normal),
    ]
    
    UIBarButtonItem.appearance().tintColor = .white
    UIBarButtonItem.appearance().setTitleTextAttributes([
      .font: UIFont.spc_standard(size: 16),
    ], for: .normal)
  }
}
