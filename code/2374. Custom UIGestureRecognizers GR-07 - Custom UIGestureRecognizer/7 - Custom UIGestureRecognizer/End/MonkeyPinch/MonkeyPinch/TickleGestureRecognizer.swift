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

import UIKit

class TickleGestureRecognizer: UIGestureRecognizer {
  let requiredTickleCount = 3
  let tickleDistanceRange: ClosedRange<CGFloat> = 2.5...25
  
  var tickleCount = 0
  var touchLocation: CGPoint?
  var tickleDirection: CGPoint?
  var totalDistanceSinceDirectionSwitch: CGFloat = 0
  
  override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent) {
    guard let touch = touches.first else {
      return
    }
    
    touchLocation = touch.location(in: view)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent) {
    guard
      let touch = touches.first,
      let lastTouchLocation = self.touchLocation
    else {
      return
    }
    
    let touchLocation = touch.location(in: view)
    let touchLocationChange = CGPoint(
      x: touchLocation.x - lastTouchLocation.x,
      y: touchLocation.y - lastTouchLocation.y
    )
    self.touchLocation = touchLocation
    let tickleDistance = (
      touchLocationChange.x * touchLocationChange.x
      + touchLocationChange.y * touchLocationChange.y
    ).squareRoot()
    
    guard tickleDistance > tickleDistanceRange.lowerBound else {
      return
    }
    
    switch tickleDirection {
    case let tickleDirection?:
      let dotProduct =
        touchLocation.x * tickleDirection.x
        + touchLocation.y * tickleDirection.y
      
      guard dotProduct < 0 else {
        fallthrough
      }
      
      tickleCount += 1
      self.tickleDirection = touchLocationChange
      totalDistanceSinceDirectionSwitch = 0
      if state == .possible && tickleCount == requiredTickleCount {
        state = .ended
      }
    case nil:
      tickleDirection = touchLocationChange
      fallthrough
    default:
      totalDistanceSinceDirectionSwitch += tickleDistance
      if totalDistanceSinceDirectionSwitch > tickleDistanceRange.upperBound {
        state = .failed
      }
    }
  }
  
  override func reset() {
    tickleCount = 0
    touchLocation = nil
    tickleDirection = nil
    totalDistanceSinceDirectionSwitch = 0
  }
  
  override func touchesEnded(_: Set<UITouch>, with _: UIEvent) {
    reset()
  }
  
  override func touchesCancelled(_: Set<UITouch>, with _: UIEvent) {
    reset()
  }
}
