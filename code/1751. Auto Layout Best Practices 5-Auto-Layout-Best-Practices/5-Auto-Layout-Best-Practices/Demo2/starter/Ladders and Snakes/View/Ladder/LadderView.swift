///// Copyright (c) 2018 Razeware LLC
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


// MARK: - Flippable

protocol Flippable {
  func flip(to: Direction)
}

extension UIImageView: Flippable {
  func flip(to direction: Direction) {
    switch direction {
    case .facesLeft:
      transform = transform.scaledBy(x: -1, y: 1)
    default: break
    }
  }
}


// MARK: - Rotatable

protocol Rotatable {
  func rotate(degrees: CGFloat)
}

extension UIImageView: Rotatable {
  func rotate(degrees: CGFloat) {
    transform = transform.rotated(by: CGFloat(degrees * .pi / 180))
  }
}

// MARK: - Sizeable

protocol Sizeable {
  func addSizeConstraints(width: CGFloat, height: CGFloat)
}

extension UIImageView: Sizeable {
  func addSizeConstraints(width: CGFloat, height: CGFloat) {
    // Will be added as part of Demo 2.
  }
}


// MARK: - Animation

extension UIImageView {
  func fade(to alpha: Alpha = .hidden, with duration: TimeInterval = 0.3) {
    UIView.animate(withDuration: duration) {
      self.alpha = alpha.rawValue
    }
  }
}

// MARK: - LadderView

class LadderView: UIImageView {
  // Will be added as part of Demo 2.
  
//  class func create(size: CGFloat, rotation: CGFloat = 0, direction: Direction = .facesRight, alpha: Alpha = .hidden) -> LadderView {
//    let ladder = LadderView(image: #imageLiteral(resourceName: "ladder"))
//    ladder.alpha = alpha.rawValue
//    ladder.contentMode = .scaleAspectFit
//    ladder.flip(to: direction)
//    ladder.rotate(degrees: rotation)
//    ladder.addSizeConstraints(width: size, height: size)
//    return ladder
//  }
  
}

