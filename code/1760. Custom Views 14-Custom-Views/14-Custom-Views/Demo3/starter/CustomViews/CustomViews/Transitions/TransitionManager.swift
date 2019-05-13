///// Copyright (c) 2017 Razeware LLC
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

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {

  //MARK: Helpers
  let transitionDuration: Double = 0.5
  var isPresenting: Bool = true
  
  private let blurEffectView: UIVisualEffectView = {
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
    return UIVisualEffectView(effect: blurEffect)
  }()
  
  private let dimmingView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }()
  
  private let whiteScrollView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  private func addBackgroundViews(containerView: UIView) {
    blurEffectView.frame = containerView.frame
    blurEffectView.alpha = isPresenting ? 0 : 1
    
    dimmingView.frame = containerView.frame
    dimmingView.alpha = isPresenting ? 0 : 0.1
    
    containerView.addSubview(blurEffectView)
    containerView.addSubview(dimmingView)
  }
  
  private func createCardViewCopy(cardView: CardView) -> CardView {
    let cardModel = cardView.cardModel
    cardModel.viewMode = isPresenting ? .card : .full
    let newAppView: AppView? = AppView(cardView.appView?.viewModel)
    let cardViewCopy = CardView(cardModel: cardModel, appView: newAppView)
    return cardViewCopy
  }

  //MARK: UIViewControllerAnimatedTransitioning protocol methods
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return transitionDuration
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    // Remove all views from container to start fresh and add the background views
    let containerView = transitionContext.containerView
    containerView.subviews.forEach{ $0.removeFromSuperview() }
    addBackgroundViews(containerView: containerView)
    
    let fromVC = transitionContext.viewController(forKey: .from)
    let toVC = transitionContext.viewController(forKey: .to)
    
    // Grab the selected cardView to create a cardViewCopy that we can manipulate
    guard let cardView = isPresenting ? (fromVC as! TodayViewController).selectedCellCardView() : (toVC as! TodayViewController).selectedCellCardView() else { return }
    
    // Hide the original cardView so that you can seamlessly scale the cardViewCopy to be smaller
    cardView.isHidden = true
    let cardViewCopy = createCardViewCopy(cardView: cardView)
    
    // Configure and insert whiteStrip view to animate with the cardView
    whiteScrollView.frame = isPresenting ? cardView.containerView.frame : containerView.frame
    whiteScrollView.layer.cornerRadius = isPresenting ? 20 : 0
    cardViewCopy.insertSubview(whiteScrollView, aboveSubview: cardViewCopy.shadowView)
    
    // Add the cardViewCopy
    containerView.addSubview(cardViewCopy)
    
    // Get the relative rect for your cardViewCopy to set the frame
    let absoluteCardViewFrame = cardView.convert(cardView.frame, to: nil)
    
    if isPresenting {
      // Add the toVC view so it can appear on the screen
      let toVC = toVC as! DetailViewController
      containerView.addSubview(toVC.view)
      toVC.viewsAreHidden = true
      
      cardViewCopy.frame = absoluteCardViewFrame
      
      makeSmaller(cardView: cardViewCopy, with: {
        self.moveAndConvertCardView(cardView: cardViewCopy, containerView: containerView, yOriginToMoveTo: absoluteCardViewFrame.origin.y, completion: {
          // Unhide and remove all necessary views
          cardView.isHidden = false
          toVC.viewsAreHidden = false
          cardViewCopy.removeFromSuperview()
          transitionContext.completeTransition(true)
        })
      })
    } else {
      let fromVC = fromVC as! DetailViewController
      
      cardViewCopy.frame = fromVC.cardView!.frame
      fromVC.viewsAreHidden = true
      
      moveAndConvertCardView(cardView: cardViewCopy, containerView: containerView, yOriginToMoveTo: absoluteCardViewFrame.origin.y, completion: {
        
        // Unhide and remove all necessary views
        cardView.isHidden = false
        transitionContext.completeTransition(true)
      })
    }
  }

  //MARK: Animation methods
  private func makeSmaller(cardView: CardView, with completion: (() ->())?) {
    UIView.animate(withDuration: 0.2, animations: {
      cardView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
      self.dimmingView.alpha = 0.05
    }) { (completed) in
      completion?()
    }
  }
  
  private func moveAndConvertCardView(cardView: CardView, containerView: UIView, yOriginToMoveTo: CGFloat, completion: @escaping () ->()) {
    
    cardView.layoutIfNeeded()
    
    if !isPresenting {
      cardView.addShadow()
      cardView.updateConstraints(for: .card)
    } else {
      cardView.updateConstraints(for: .full)
    }
    
    let yOriginAnimation = yOriginMoveAndBounceAnimation()
    
    UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
      cardView.transform = CGAffineTransform(scaleX: 1, y: 1)
      cardView.containerView.layer.cornerRadius = self.isPresenting ? 0 : 20
      
      yOriginAnimation.toValue = self.isPresenting ? -yOriginToMoveTo : yOriginToMoveTo
      cardView.layer.add(yOriginAnimation, forKey: "yMove")
      
      self.whiteScrollView.layer.cornerRadius = self.isPresenting ? 0 : 20
      self.blurEffectView.alpha = self.isPresenting ? 1 : 0.0
      self.dimmingView.alpha = self.isPresenting ? 0.1 : 0.0
      
      containerView.layoutIfNeeded()
      self.whiteScrollView.frame = self.isPresenting ? containerView.frame : cardView.containerView.frame
      
    }, completion: { (completed) in
      completion()
    })
  }
  
  private func yOriginMoveAndBounceAnimation() -> CASpringAnimation {
    // NOTE: Swift 4 convention dictates using keyPaths like this: #keyPath(CALayer.position.y),
    // But at the moment, Xcode won't allow that specific keyPath, so keeping it as a string for now
    let yMoveAnimation = CASpringAnimation(keyPath: "position.y")
    yMoveAnimation.damping = 14
    yMoveAnimation.initialVelocity = 7
    yMoveAnimation.mass = 0.9
    yMoveAnimation.duration = yMoveAnimation.settlingDuration
    yMoveAnimation.isAdditive = true
    yMoveAnimation.isRemovedOnCompletion = false
    yMoveAnimation.fillMode = kCAFillModeBoth
    yMoveAnimation.fromValue = 0
    return yMoveAnimation
  }
}

//MARK: UIViewControllerTransitioningDelegate
extension TransitionManager: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    isPresenting = true
    return self
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    isPresenting = false
    return self
  }
}

