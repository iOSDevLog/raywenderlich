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

private let sceneHeight: CGFloat = 180

protocol RefreshViewDelegate: class {
    func refreshViewDidRefresh(refreshView: RefreshView)
}

class RefreshView: UIView {

  private unowned var scrollView: UIScrollView
  var progressPercentage: CGFloat = 0
  var refreshItems = [RefreshItem]()
  var refreshing = false
  weak var delegate: RefreshViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    scrollView = UIScrollView()
    super.init(coder:aDecoder)!
    
    setupRefreshItems()
    
  }
  
  func setupRefreshItems() {
    let groundImageView = UIImageView(image:UIImage(named: "ground"))
    let buildingsImageView = UIImageView(image:UIImage(named: "buildings"))
    let sunImageView = UIImageView(image:UIImage(named: "sun"))
    let catImageView = UIImageView(image:UIImage(named: "cat"))
    let capeBackImageView = UIImageView(image:UIImage(named: "cape_back"))
    let capeFrontImageView = UIImageView(image:UIImage(named: "cape_front"))
    
    refreshItems = [
    
      RefreshItem(view: buildingsImageView, centerEnd: CGPoint(x: bounds.midX, y: bounds.height - groundImageView.bounds.height - buildingsImageView.bounds.height / 2), parallaxRatio: 1.5, sceneHeight: sceneHeight),
      RefreshItem(view: sunImageView, centerEnd: CGPoint(x: bounds.width * 0.1, y: bounds.height - groundImageView.bounds.height - sunImageView.bounds.height ), parallaxRatio: 3, sceneHeight: sceneHeight),
      RefreshItem(view: groundImageView, centerEnd: CGPoint(x: bounds.midX, y: bounds.height - groundImageView.bounds.height / 2), parallaxRatio: 0.5, sceneHeight: sceneHeight),
      RefreshItem(view: capeBackImageView, centerEnd: CGPoint(x: bounds.midX, y: bounds.height - groundImageView.bounds.height/2 - capeBackImageView.bounds.height / 2), parallaxRatio: -1, sceneHeight: sceneHeight),
      
      RefreshItem(view: catImageView, centerEnd: CGPoint(x: bounds.midX, y: bounds.height - groundImageView.bounds.height/2 - catImageView.bounds.height / 2), parallaxRatio: 1, sceneHeight: sceneHeight),
      RefreshItem(view: capeFrontImageView, centerEnd: CGPoint(x: bounds.midX, y: bounds.height - groundImageView.bounds.height / 2 - capeFrontImageView.bounds.height / 2), parallaxRatio: -1, sceneHeight: sceneHeight)
    ]
    
    for refreshItem in refreshItems {
      addSubview(refreshItem.view)
    }
    
    
  }
  
  func updateRefreshItemPositions() {
    for refreshItem in refreshItems {
      refreshItem.updateViewPositionForPercentage(progressPercentage)
    }
  }
  
  
  init(frame: CGRect, scrollView: UIScrollView) {
    self.scrollView = scrollView
    super.init(frame:frame)
    clipsToBounds = true
    backgroundColor = UIColor.green
    setupRefreshItems()
  }
  
  func updateBackgroundColor() {
    let value = progressPercentage * 0.7 + 0.2
    backgroundColor = UIColor(red:value, green:value, blue:value, alpha:1.0)
  }
  
 func beginRefreshing() {
  refreshing = true
  UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
    () -> Void in
      self.scrollView.contentInset.top += sceneHeight
    }, completion: { (_) -> Void in
  
    })
  }
 func endRefreshing() {
  refreshing = false
  UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
    () -> Void in
      self.scrollView.contentInset.top -= sceneHeight
    }, completion: { (_) -> Void in
  
    })
  }
  
}


extension RefreshView: UIScrollViewDelegate {

  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
  if !refreshing && progressPercentage == 1 {
    beginRefreshing()
    targetContentOffset.pointee.y = -scrollView.contentInset.top
    delegate?.refreshViewDidRefresh(refreshView: self)
  }
}

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if refreshing {
      return
    }
    let refreshViewVisibleHeight = max(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))
    progressPercentage = min(1, refreshViewVisibleHeight / sceneHeight)
    print("progress percetntage: \(progressPercentage)")
    updateBackgroundColor()
    updateRefreshItemPositions()
  }
}








