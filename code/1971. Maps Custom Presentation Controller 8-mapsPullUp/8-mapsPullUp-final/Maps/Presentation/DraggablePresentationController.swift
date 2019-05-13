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

private extension CGFloat {
  // Spring animation
  static let springDampingRatio: CGFloat = 0.7
  static let springInitialVelocityY: CGFloat =  10
}

private extension Double {
  // Spring animation
  static let animationDuration: Double = 0.8
}

enum DragDirection {
  case up
  case down
}

enum DraggablePosition {
  case collapsed
  case open
  
  var heightmultiplier: CGFloat {
    switch self {
    case .collapsed: return 0.2
    case .open: return 1
    }
  }
  
  var downBoundary: CGFloat {
    switch self {
    case .collapsed: return 0.0
    case .open: return 0.8
    }
  }
  
  var upBoundary: CGFloat {
    switch self {
    case .collapsed: return 0.0
    case .open: return 0.65
    }
  }
  
  var dimAlpha: CGFloat {
    switch self {
    case .collapsed: return 0.0
    case .open: return 0.45
    }
  }
  
  func yOrigin(for maxHeight: CGFloat) -> CGFloat {
    return maxHeight - (maxHeight * heightmultiplier)
  }
  
  func nextPosition(for direction: DragDirection) -> DraggablePosition {
    switch (self, direction) {
    case (.collapsed, .up): return .open
    case (.collapsed, .down): return .collapsed
    case (.open, .up): return .open
    case (.open, .down): return .collapsed
    }
  }
}

final class DraggablePresentationController: UIPresentationController {
  
  // MARK: Private
  private var dimmingView = UIView()
  private var draggablePosition: DraggablePosition = .collapsed
  
  private let springTiming = UISpringTimingParameters(dampingRatio: .springDampingRatio, initialVelocity: CGVector(dx: 0, dy: .springInitialVelocityY))
  private var animator: UIViewPropertyAnimator?
  
  private var dragDirection: DragDirection = .up
  private let maxFrame = CGRect(x: 0, y: 0, width: UIWindow.root.bounds.width, height: UIWindow.root.bounds.height + UIWindow.key.safeAreaInsets.bottom)
  private var panOnPresented = UIGestureRecognizer()
  
  override var frameOfPresentedViewInContainerView: CGRect {
    let presentedOrigin = CGPoint(x: 0, y: draggablePosition.yOrigin(for: maxFrame.height))
    let presentedSize = CGSize(width: maxFrame.width, height: maxFrame.height + 40)
    let presentedFrame = CGRect(origin: presentedOrigin, size: presentedSize)
    
    return presentedFrame
  }
  
  override func presentationTransitionWillBegin() {
    guard let containerView = containerView else { return }
    
    containerView.insertSubview(dimmingView, at: 1)
    dimmingView.alpha = 0
    dimmingView.backgroundColor = .black
    dimmingView.frame = containerView.frame
  }
  
  override func presentationTransitionDidEnd(_ completed: Bool) {
    animator = UIViewPropertyAnimator(duration: .animationDuration, timingParameters: self.springTiming)
    animator?.isInterruptible = true
    panOnPresented = UIPanGestureRecognizer(target: self, action: #selector(userDidPan(panRecognizer:)))
    presentedView?.addGestureRecognizer(panOnPresented)
  }
  
  override func containerViewWillLayoutSubviews() {
    presentedView?.frame = frameOfPresentedViewInContainerView
  }
  
  @objc private func userDidPan(panRecognizer: UIPanGestureRecognizer) {
    let translationPoint = panRecognizer.translation(in: presentedView)
    let currentOriginY = draggablePosition.yOrigin(for: maxFrame.height)
    let newOffset = currentOriginY + translationPoint.y
    
    dragDirection = newOffset > currentOriginY ? .down : .up
    
    let canDragInProposedDirection = dragDirection == .up && draggablePosition == .open ? false : true
    
    if newOffset >= 0 && canDragInProposedDirection {
      switch panRecognizer.state {
      case .changed, .began:
        presentedView?.frame.origin.y = newOffset
      case .ended:
        animate(newOffset)
      default: break
      }
    }
  }
  
  private func animate(_ dragOffset: CGFloat) {
    
    let distanceFromBottom = maxFrame.height - dragOffset
    
    switch dragDirection {
    case .up:
      if (distanceFromBottom > maxFrame.height * DraggablePosition.open.upBoundary) {
        animate(to: .open)
      } else {
        animate(to: .collapsed)
      }
    case .down:
      if (distanceFromBottom > maxFrame.height * DraggablePosition.open.downBoundary) {
        animate(to: .open)
      } else {
        animate(to: .collapsed)
      }
    }
  }
  
  private func animate(to position: DraggablePosition) {
    
    guard let animator = animator else { return }
    
    animator.addAnimations {
      self.presentedView?.frame.origin.y = position.yOrigin(for: self.maxFrame.height)
      self.dimmingView.alpha = position.dimAlpha
    }
    
    animator.addCompletion { (animatingPosition) in
      if animatingPosition == .end {
        self.draggablePosition = position
      }
    }
    
    animator.startAnimation()
  }
}

// MARK: Public
extension DraggablePresentationController {
  func animateToOpen() {
    animate(to: .open)
  }
}

