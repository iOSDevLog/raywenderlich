//
//  AppDelegate.swift
//  Spacetime
//
//  Created by Ellen Shapiro on 10/22/17.
//  Copyright © 2017 RayWenderlich.com. All rights reserved.
//

import SpacetimeUI
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func applicationDidFinishLaunching(_ application: UIApplication) {
    self.setupAppearanceProxies()
  }
  
  private func setupAppearanceProxies() {
    UITabBar.appearance().tintColor = SpacetimeColor.tabBarContent.color
    UITabBarItem.appearance().setTitleTextAttributes([
      .font: SpacetimeFont.standard.of(size: .tiny),
      ], for: .normal)
    
    UINavigationBar.appearance().barTintColor = SpacetimeColor.navigationBarBackground.color
    UINavigationBar.appearance().titleTextAttributes = [
      .foregroundColor: SpacetimeColor.navigationBarContent.color,
      .font: SpacetimeFont.bold.of(size: .normal),
    ]
    
    UIBarButtonItem.appearance().tintColor = SpacetimeColor.navigationBarContent.color
    UIBarButtonItem.appearance().setTitleTextAttributes([
      .font: SpacetimeFont.standard.of(size: .medium),
    ], for: .normal)
  }
}
