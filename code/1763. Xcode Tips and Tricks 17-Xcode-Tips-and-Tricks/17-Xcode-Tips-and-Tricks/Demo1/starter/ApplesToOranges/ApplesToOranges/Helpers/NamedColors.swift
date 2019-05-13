/**
 * Copyright (c) 2018 Razeware LLC
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

import UIKit

extension UIColor {
  static var raspberryRed: UIColor { return colorFromAssetCatalog() }
  static var defaultGreen: UIColor { return colorFromAssetCatalog("rayWenderlichGreen") }
  static var banannaYellow = UIColor(red: 1.0, green: 0.9, blue: 0.2, alpha: 1)
  static var blueberryBlue = #colorLiteral(red: 0.3098039216, green: 0.5254901961, blue: 0.968627451, alpha: 1)

  /// A helper method that returns a color with the specified name from the asset catalog
  ///
  /// - Parameter colorName: The color to return. Uses the method name if ommitted.
  /// - Returns: A UIColor from the asset catalog
  private static func colorFromAssetCatalog(_ colorName: String = #function) -> UIColor {
    guard let color = UIColor(named: colorName) else {
      fatalError("Could not find color named \(colorName) in asset catalog")
    }
    return color
  }
}
