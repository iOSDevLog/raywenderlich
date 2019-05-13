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

  var image: UIImage!
  @IBOutlet weak var predictionLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var faceBoxView: UIView!

  // Step 3


  // Step 4a: Create openFaceRequest to generate embedding for images


  // Step 4b: openFaceRequest's handler passes embedding to classifier
  func handleOpenface(request: VNRequest, error: Error?) {

  }

  // Step 5: Run classifer on embedding

  func classifyFace(_ embedding: MLMultiArray) {

  }

  // Step 6a: Run openFaceRequest on image
  func predictIdentity(image: UIImage) {

  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
    imageView.image = image
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // Step 6b: Call predictIdentity

    // No-Vision alternative
//    predictIdentityWithoutVision()
  }

  // MARK: - Bonus Code
  /*
  let openFaceModelWithoutVision = OpenFace()
  func predictIdentityWithoutVision() {
    guard let pixelBuffer = image.pixelBuffer() else {
      fatalError("Can't get pixel buffer.")
    }
    DispatchQueue.global(qos: .userInteractive).async {
      do {
        let embeddings = try self.openFaceModelWithoutVision.prediction(data: pixelBuffer)
        self.classifyFace((embeddings.featureValue(for: "output")?.multiArrayValue)!)
      } catch {
        fatalError("Can't get embeddings: \(error).")
      }
    }
  }
 */

}
