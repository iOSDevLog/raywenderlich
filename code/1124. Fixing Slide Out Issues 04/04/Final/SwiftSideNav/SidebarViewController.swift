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

class SidebarViewController: UIViewController {
  var leftViewController: UIViewController!
  var mainViewController: UIViewController!
  var overlap: CGFloat!
  var scrollView: UIScrollView!
  var firstTime = true

  required init(coder aDecoder: NSCoder) {
    assert(false, "Use init(leftViewController:mainViewController:overlap:)")
    super.init(coder: aDecoder)!
  }

  init(leftViewController: UIViewController, mainViewController: UIViewController, overlap: CGFloat) {
    self.leftViewController = leftViewController
    self.mainViewController = mainViewController
    self.overlap = overlap

    super.init(nibName: nil, bundle: nil)

    self.view.backgroundColor = UIColor.black

    setupScrollView()
    setupViewControllers()
  }

  override func viewDidLayoutSubviews() {
    if firstTime {
      firstTime = false
      closeMenuAnimated(false)
    }
  }

  func closeMenuAnimated(_ animated: Bool) {
    scrollView.setContentOffset(CGPoint(x: leftViewController.view.frame.width, y:0), animated: animated)
  }
  
  func leftMenuIsOpen() -> Bool {
    return scrollView.contentOffset.x == 0
  }
  
  func openLeftMenuAnimated(_ animated: Bool) {
    scrollView.setContentOffset(CGPoint(x:0, y:0), animated: animated)
  }
  
  func toggleLeftAnimated(_ animated: Bool) {
    if leftMenuIsOpen() {
      closeMenuAnimated(animated)
    } else {
      openLeftMenuAnimated(animated)
    }
  }
  

  func setupScrollView() {
    scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isPagingEnabled = true
    scrollView.bounces = false
    view.addSubview(scrollView)

    let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView])
    let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView])
    NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints)
  }

  func setupViewControllers() {
    addViewController(leftViewController)
    addViewController(mainViewController)
    addShadowToView(mainViewController.view)
    let views: [String: UIView] = ["left": leftViewController.view, "main": mainViewController.view, "outer": view]
    let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|[left][main(==outer)]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
    let leftWidthConstraint = NSLayoutConstraint(item: leftViewController.view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: -overlap)
    let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[main(==outer)]|", options: [], metrics: nil, views: views)
    NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints + [leftWidthConstraint])
  }
  
  private func addViewController(_ viewController: UIViewController) {
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(viewController.view)
    addChildViewController(viewController)
    viewController.didMove(toParentViewController: self)
  }
  
  private func addShadowToView(_ destView: UIView) {
    destView.layer.shadowPath = UIBezierPath(rect: destView.bounds).cgPath
    destView.layer.shadowRadius = 2.5
    destView.layer.shadowOffset = CGSize(width:0, height:0)
    destView.layer.shadowOpacity = 1.0
    destView.layer.shadowColor = UIColor.black.cgColor
  }
  
  
  
  
  
  
  
  
  
  
  
  
}
