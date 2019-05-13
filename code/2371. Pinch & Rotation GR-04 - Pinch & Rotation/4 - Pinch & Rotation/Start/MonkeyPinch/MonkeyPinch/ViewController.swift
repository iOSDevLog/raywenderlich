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

class ViewController: UIViewController {
  @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
    guard let recognizerView = recognizer.view else {
      return
    }
    
    let translation = recognizer.translation(in: view)
    recognizerView.center.x += translation.x
    recognizerView.center.y += translation.y
    recognizer.setTranslation(.zero, in: view)
    
    guard recognizer.state == .ended else {
      return
    }
    
    let velocity = recognizer.velocity(in: view)
    let vectorToFinalPoint = CGPoint(x: velocity.x / 15, y: velocity.y / 15)
    let bounds = UIEdgeInsetsInsetRect(view.bounds, view.safeAreaInsets)
    var finalPoint = recognizerView.center
    finalPoint.x += vectorToFinalPoint.x
    finalPoint.y += vectorToFinalPoint.y
    finalPoint.x = min(max(finalPoint.x, bounds.minX), bounds.maxX)
    finalPoint.y = min(max(finalPoint.y, bounds.minY), bounds.maxY)
    let vectorToFinalPointLength = (
      vectorToFinalPoint.x * vectorToFinalPoint.x
      + vectorToFinalPoint.y * vectorToFinalPoint.y
    ).squareRoot()
    
    UIView.animate(
      withDuration: TimeInterval(vectorToFinalPointLength / 1800),
      delay: 0,
      options: .curveEaseOut,
      animations: { recognizerView.center = finalPoint }
    )
  }
}
