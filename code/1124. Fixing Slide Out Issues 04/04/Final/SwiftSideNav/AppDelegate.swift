/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  var iconViewControllers = [IconTableViewController]()

  var iconsNav: UINavigationController!
  var menuNav: UINavigationController!
  var sidebarVC: SidebarViewController!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

    for iconSet in IconHelper.allIconSets() {
      let iconVC = storyboard.instantiateViewController(withIdentifier: "IconsVC") as! IconTableViewController
      iconVC.delegate = self
      iconVC.iconSet = iconSet

      iconViewControllers.append(iconVC)
    }

    iconsNav = UINavigationController(rootViewController: iconViewControllers[0])

    let menuVC = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuTableViewController
    menuVC.delegate = self
    menuNav = UINavigationController(rootViewController: menuVC)
    
    sidebarVC = SidebarViewController(leftViewController: menuNav, mainViewController: iconsNav, overlap: 70)

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = UIColor.white
    window?.rootViewController = sidebarVC
    window?.makeKeyAndVisible()

    return true
  }

}

extension AppDelegate: IconTableViewControllerDelegate {
  func iconTableViewControllerDidTapMenuButton(_ controller: IconTableViewController) {
    sidebarVC.toggleLeftAnimated(true)
  }
}

extension AppDelegate: MenuTableViewControllerDelegate {
  func menuTableViewController(_ controller: MenuTableViewController, didSelectRow row: Int) {
    
    sidebarVC.closeMenuAnimated(true)
    let destinationViewController = iconViewControllers[row]
    if iconsNav.topViewController != destinationViewController {
      iconsNav.setViewControllers([destinationViewController], animated: true)
    }
  }
}
