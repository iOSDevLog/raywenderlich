/**
 * Copyright (c) 2017 Razeware LLC
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
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import MapKit
import UIKit

class WarpZone: NSObject, MKAnnotation {

  // MARK: - Properties
  let coordinate: CLLocationCoordinate2D
  let color: UIColor

  // MARK: - Initializers
  init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, color: UIColor) {
    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    self.color = color
    super.init()
  }
}

extension WarpZone {

  var image: UIImage {
    return #imageLiteral(resourceName: "warp").maskWithColor(color: self.color)
  }
}

class WarpAnnotationView: MKAnnotationView {
  static let identifier = "WarpZone"

  override var annotation: MKAnnotation? {
    get { return super.annotation }
    set {
      super.annotation = newValue
      guard let warp = newValue as? WarpZone else { return }

      self.image = warp.image
    }
  }
}

extension UIImage {

  func maskWithColor(color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
    let context = UIGraphicsGetCurrentContext()!

    color.setFill()

    context.translateBy(x: 0, y: size.height)
    context.scaleBy(x: 1.0, y: -1.0)

    let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
    context.draw(cgImage!, in: rect)

    context.setBlendMode(.sourceIn)
    context.addRect(rect)
    context.drawPath(using: .fill)

    let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return coloredImage!
  }
}
