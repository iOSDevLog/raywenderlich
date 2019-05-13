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

final class MapViewController: UIViewController {
  @IBOutlet var desiredXConstraint: NSLayoutConstraint!
  @IBOutlet var desiredYConstraint: NSLayoutConstraint!
  @IBOutlet var marker: UIView!
  @IBOutlet var markerImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setMarkerToArrowOrX()
  }
  
  func setMarkerToArrowOrX() {
    let currentPoint = marker.frame.origin
    let desiredPoint = CGPoint(
      x: desiredXConstraint.constant,
      y: desiredYConstraint.constant
    )
    
    let imageName: String
    let transform: CGAffineTransform
    
    if currentPoint == desiredPoint {
      imageName = "x"
      transform = .identity
    }
    else {
      imageName = "arrow"
      transform = CGAffineTransform(
        rotationAngle: (desiredPoint - currentPoint).angle
      )
    }
    
    markerImageView.image = UIImage(named: imageName)
    markerImageView.transform = transform
  }
}

//MARK: UIScrollViewDelegate
extension MapViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_: UIScrollView) {
    setMarkerToArrowOrX()
  }
}

private extension CGPoint {
  var angle: CGFloat {
    return atan2(y, x)
  }
  
  static func - (point0: CGPoint, point1: CGPoint) -> CGPoint {
    return CGPoint(
      x: point0.x - point1.x,
      y: point0.y - point1.y
    )
  }
}
