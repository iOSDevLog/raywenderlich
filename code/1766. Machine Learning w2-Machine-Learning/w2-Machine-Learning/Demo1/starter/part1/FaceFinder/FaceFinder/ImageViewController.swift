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
import Vision

class ImageViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var faceBoxView: UIView!

  var image: UIImage!
  var maskLayer = [CAShapeLayer]()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    removeMask()
    imageView.image = image
    guard let cgImage = image.cgImage else {
      fatalError("Can't create CGImage.")
    }

    // Step 2

  }

  // Step 3
  func handleFaces(request: VNRequest, error: Error?) {

  }

}

extension ImageViewController {
  func drawFaceBoxes(observations: [VNFaceObservation]) {
    let viewSize = imageView.bounds.size
    let imageSize = image.size

    let widthRatio = viewSize.width / imageSize.width
    let heightRatio = viewSize.height / imageSize.height
    let scaledRatio = min(widthRatio, heightRatio)

    let scaleTransform = CGAffineTransform(scaleX: scaledRatio, y: scaledRatio)
    let scaledImageSize = imageSize.applying(scaleTransform)

    let imageX = (viewSize.width - scaledImageSize.width) / 2
    let imageY = (viewSize.height - scaledImageSize.height) / 2
    let imageLocationTransform = CGAffineTransform(translationX: imageX, y: imageY)

    let uiTransform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -imageSize.height)

    for face in observations {
      let observedFaceBox = face.boundingBox
      let faceBox = observedFaceBox
        .scaled(to: imageSize)
        .applying(uiTransform)
        .applying(scaleTransform)
        .applying(imageLocationTransform)

      _ = createLayer(in: faceBox)
    }
  }

  func createLayer(in rect: CGRect) -> CAShapeLayer{
    let mask = CAShapeLayer()
    mask.frame = rect
    mask.cornerRadius = 10
    mask.opacity = 0.75
    mask.borderColor = UIColor.green.cgColor
    mask.borderWidth = 2.0

    maskLayer.append(mask)
    faceBoxView.layer.insertSublayer(mask, at: 1)

    return mask
  }

  func removeMask() {
    for mask in maskLayer {
      mask.removeFromSuperlayer()
    }
    maskLayer.removeAll()
  }

}
