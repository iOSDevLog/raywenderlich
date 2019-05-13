/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  private let rootVC = CatFeedViewController()

  var firstTime: TimeInterval = 0.0
  var lastTime: TimeInterval = 0.0
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let logger = CatLogger()
    logger.startLogging()

    window = WindowWithStatusBar(frame: UIScreen.main.bounds)
    let rootNavController = UINavigationController(rootViewController: rootVC)
    
    let font = UIFont(name: "OleoScript-Regular", size: 20.0)!
    rootNavController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: font]
    rootNavController.navigationBar.barTintColor = UIColor.white
    rootNavController.navigationBar.isOpaque = true
    rootNavController.navigationItem.titleView?.isOpaque = true
    rootNavController.navigationBar.isTranslucent = false
    window?.rootViewController = rootNavController
    window?.makeKeyAndVisible()
    
    // Add CADisplayLink to track frame drops
    let link = CADisplayLink(target: self, selector: #selector(update(link:)))
    link.add(to: .main, forMode: .commonModes)
    
    return true
  }
  
  @objc func update(link: CADisplayLink) {
    if lastTime == 0 {
      firstTime = link.timestamp
      lastTime = link.timestamp
    }
    
    let currentTime = link.timestamp
    
    let elapsedTime = floor((currentTime - lastTime) * 10_000)/10
    let totalElapsedTime = currentTime - firstTime
    if elapsedTime > 16.7 {
      print("Frame was dropped with elpased time of \(elapsedTime)ms at \(totalElapsedTime)")
    }
    lastTime = link.timestamp
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Set up logging
    
  }
}

