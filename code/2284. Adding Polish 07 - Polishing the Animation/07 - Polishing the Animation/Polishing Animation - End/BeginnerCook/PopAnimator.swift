/// Copyright (c) 2018 Razeware LLC
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

import Foundation
import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  let duration = 1.0
  var originFrame = CGRect.zero
  var presenting = true
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    //1 - Set up transition
    let containerView = transitionContext.containerView
    guard let toView = transitionContext.view(forKey: .to) else { return }
    guard let herbView = presenting ? toView : transitionContext.view(forKey: .from) else { return }
    
    let initialFrame = presenting ? originFrame : herbView.frame
    let finalFrame = presenting ? herbView.frame : originFrame
    
    let xScaleFactor = presenting
      ? initialFrame.width / finalFrame.width
      : finalFrame.width / initialFrame.width
    let yScaleFactor = presenting
      ? initialFrame.height / finalFrame.height
      : finalFrame.height / initialFrame.height
    let scaleFactor = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
    
    if presenting {
      herbView.transform = scaleFactor
      herbView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
    }
    herbView.layer.cornerRadius = presenting ? 20.0 / xScaleFactor : 0.0
    herbView.clipsToBounds = true
    containerView.addSubview(toView)
    containerView.bringSubviewToFront(herbView)
    
    guard let herbController = transitionContext.viewController(
      forKey: presenting ? .to : .from
      ) as? HerbDetailsViewController else { return }
    if presenting {
      herbController.containerView.alpha = 0.0
    }
    //2 - Animate!
    UIView.animate(
      withDuration: duration,
      delay: 0.0,
      usingSpringWithDamping: 0.4,
      initialSpringVelocity: 0.0,
      animations: {
        herbView.layer.cornerRadius = self.presenting ? 0.0 : 20.0 / xScaleFactor
        herbView.transform = self.presenting ? .identity : scaleFactor
        herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        herbController.containerView.alpha = self.presenting ? 1.0 : 0.0
      }
    ) { _ in
      //3 - Complete transition
      if !self.presenting {
        let viewController = transitionContext.viewController(forKey: .to) as! ViewController
        viewController.selectedImage?.isHidden = false
      }
      transitionContext.completeTransition(true)
    }
  }
  
  
}
