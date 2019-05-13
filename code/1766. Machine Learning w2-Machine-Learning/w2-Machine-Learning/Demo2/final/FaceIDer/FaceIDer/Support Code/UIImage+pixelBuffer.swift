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

extension UIImage {
  func pixelBuffer() -> CVPixelBuffer? {
    let width = self.size.width
    let height = self.size.height
    let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
      kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
    var pixelBuffer: CVPixelBuffer?
    let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(width), Int(height),
      kCVPixelFormatType_32BGRA, attrs, &pixelBuffer)
    guard let resultPixelBuffer = pixelBuffer, status == kCVReturnSuccess else {
      print("No pixelBuffer.")
      return nil
    }
    CVPixelBufferLockBaseAddress(resultPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
    let pixelData = CVPixelBufferGetBaseAddress(resultPixelBuffer)

    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    guard let cgImage = self.cgImage else {
      print("Can't create CGImage from UIImage.")
      return nil
    }
    guard let context = CGContext(data: pixelData, width: Int(width), height: Int(height),
      bitsPerComponent: cgImage.bitsPerComponent,
      bytesPerRow: CVPixelBufferGetBytesPerRow(resultPixelBuffer),
      space: rgbColorSpace, bitmapInfo: cgImage.bitmapInfo.rawValue) else {
        print("Can't create CGContext.")
        return nil
    }
    context.translateBy(x: 0, y: height)
    context.scaleBy(x: 1.0, y: -1.0)

    UIGraphicsPushContext(context)
    self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
    UIGraphicsPopContext()
    CVPixelBufferUnlockBaseAddress(resultPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))

    return resultPixelBuffer
  }
}
