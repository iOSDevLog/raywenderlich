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

import UIKit
import MapKit

class ShimmerRenderer: MKPolygonRenderer {

  // MARK: - Properties
  var iteration = 0
  var locations: [CGFloat] = [0, 0, 0]

  func updateLocations() {
    iteration = (iteration + 1) % 15
    let minL = max(0, CGFloat(iteration - 1) / 15.0)
    let maxL = min(1.0, CGFloat(iteration + 1) / 15.0)
    let center = CGFloat(iteration) / 15.0
    locations = [minL, center, maxL]
  }

  // MARK: - LifeCycle
  override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
    super.draw(mapRect, zoomScale: zoomScale, in: context)

    UIGraphicsPushContext(context)

    let boundingRect = self.path.boundingBoxOfPath
    let minX = boundingRect.minX
    let maxX = boundingRect.maxX

    let colors = [#colorLiteral(red: 0.2431372549, green: 0.5803921569, blue: 0.9764705882, alpha: 1).cgColor, #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.8523706897).cgColor, #colorLiteral(red: 0.2431372549, green: 0.5803921569, blue: 0.9764705882, alpha: 1).cgColor]
    let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: locations)
    context.addPath(self.path)
    context.clip()
    context.drawLinearGradient(gradient!, start: CGPoint(x: minX, y: 0), end: CGPoint(x: maxX, y: 0), options: [])

    UIGraphicsPopContext()
  }
}
