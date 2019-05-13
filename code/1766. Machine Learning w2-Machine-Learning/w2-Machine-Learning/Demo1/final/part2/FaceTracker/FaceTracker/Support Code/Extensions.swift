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
import AVFoundation

extension VideoViewController {
  func drawHighlight(boundingBox: CGRect) {
    let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -cameraView.frame.height)
    let translate = CGAffineTransform.identity.scaledBy(x: cameraView.frame.width, y: cameraView.frame.height)
    let facebounds = boundingBox.applying(translate).applying(transform)
    _ = createLayer(in: facebounds)
  }

  func createLayer(in rect: CGRect) -> CAShapeLayer{
    let mask = CAShapeLayer()
    mask.frame = rect
    mask.cornerRadius = 10
    mask.opacity = 0.75
    mask.borderColor = UIColor.green.cgColor
    mask.borderWidth = 2.0

    maskLayer.append(mask)
    cameraLayer.insertSublayer(mask, at: 1)

    return mask
  }

  func removeMask() {
    for mask in maskLayer {
      mask.removeFromSuperlayer()
    }
    maskLayer.removeAll()
  }

  func exifOrientationFromDeviceOrientation() -> UInt32 {
    enum DeviceOrientation: UInt32 {
      case top0ColLeft = 1
      case top0ColRight = 2
      case bottom0ColRight = 3
      case bottom0ColLeft = 4
      case left0ColTop = 5
      case right0ColTop = 6
      case right0ColBottom = 7
      case left0ColBottom = 8
    }
    var exifOrientation: DeviceOrientation

    switch UIDevice.current.orientation {
    case .portraitUpsideDown:
      exifOrientation = .left0ColBottom
    case .landscapeLeft:
      exifOrientation = devicePosition == .front ? .bottom0ColRight : .top0ColLeft
    case .landscapeRight:
      exifOrientation = devicePosition == .front ? .top0ColLeft : .bottom0ColRight
    default:
      exifOrientation = .right0ColTop
    }
    return exifOrientation.rawValue
  }
}

extension UIDeviceOrientation {
  var videoOrientation: AVCaptureVideoOrientation? {
    switch self {
    case .portrait: return .portrait
    case .portraitUpsideDown: return .portraitUpsideDown
    case .landscapeLeft: return .landscapeRight
    case .landscapeRight: return .landscapeLeft
    default: return nil
    }
  }
}

extension UIInterfaceOrientation {
  var videoOrientation: AVCaptureVideoOrientation? {
    switch self {
    case .portrait: return .portrait
    case .portraitUpsideDown: return .portraitUpsideDown
    case .landscapeLeft: return .landscapeLeft
    case .landscapeRight: return .landscapeRight
    default: return nil
    }
  }
}

