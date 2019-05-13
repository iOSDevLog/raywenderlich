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
import ARKit
import Vision


class ViewController: UIViewController, ARSCNViewDelegate {

  @IBOutlet var sceneView: ARSCNView!
  @IBOutlet weak var observationsLabel: UILabel!

  var visionRequests = [VNRequest]()
  let dispatchQueueML = DispatchQueue(label: "com.razeware.visionquestML")
  var currentBestGuess = ""
  var currentBestGuessConfidence: VNConfidence = 0.0


  // MARK: - View initializers / events
  // ==================================

  override func viewDidLoad() {
    super.viewDidLoad()

    initSceneView()
    initARSession()
    initGestureRecognizers()
    if initVision() {

    } else {
      observationsLabel.text = "Couldn’t load the ML model. Better check the code..."
    }
  }


  // MARK: - Intializers
  // ===================

  func initSceneView() {
    sceneView.delegate = self
    sceneView.automaticallyUpdatesLighting = true
    sceneView.autoenablesDefaultLighting = true
    sceneView.showsStatistics = true
    sceneView.preferredFramesPerSecond = 60
    sceneView.antialiasingMode = .multisampling2X
    sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
  }

  func initARSession() {
    // Create a session configuration
    let configuration = ARWorldTrackingConfiguration()
    // Enable plane detection
    configuration.planeDetection = .horizontal

    // Run the view's session
    sceneView.session.run(configuration)
  }

  func initGestureRecognizers() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                      action: #selector(self.handleTap(gestureRecognize:)))
    sceneView.addGestureRecognizer(tapGestureRecognizer)
  }

  func initVision() -> Bool {
    // Load the vision model. You can find vision models at 
    // https://developer.apple.com/machine-learning/

    // Set up a request for Core ML to classify images using the vision model.

    return false
  }


  // MARK: - UI
  // ==========

  @IBAction func clearButtonPressed(_ sender: Any) {
    DispatchQueue.main.async {
      self.sceneView.scene.rootNode.enumerateChildNodes { (childNode, _) in
        childNode.removeFromParentNode()
      }
    }
  }

  @objc func handleTap(gestureRecognize: UITapGestureRecognizer) {

  }

  func createMarkerNode(text: String, confidence: VNConfidence) -> SCNNode {
    let textScaleFactor: Float = 0.15
    let textFont = "AvenirNext-BoldItalic"
    let textSize: CGFloat = 0.2
    let textDepth: CGFloat = 0.02

    // Assemble the marker text.
    let displayConfidence = String(format:"%1.0f%%", confidence * 100)
    let displayText = "\(text) [\(displayConfidence)]"

    // Create the marker text node.
    let markerText = SCNText(string: displayText,
                             extrusionDepth: CGFloat(textDepth))
    markerText.font = UIFont(name: textFont, size: textSize)?.withTraits(traits: .traitBold)
    markerText.alignmentMode = kCAAlignmentCenter
    markerText.firstMaterial?.diffuse.contents = UIColor.yellow
    markerText.firstMaterial?.specular.contents = UIColor.white
    markerText.firstMaterial?.isDoubleSided = true
    markerText.chamferRadius = CGFloat(textDepth)
    let markerNode = SCNNode(geometry: markerText)
    markerNode.scale = SCNVector3Make(textScaleFactor, textScaleFactor, textScaleFactor)

    // Make the text node pivot in its middle around the y-axis.
    let (minBound, maxBound) = markerText.boundingBox
    markerNode.pivot = SCNMatrix4MakeTranslation((maxBound.x - minBound.x)/2,
                                                 minBound.y,
                                                 0)

    // Ensure that the marker text is always readable by using a
    // Billboard constraint, which constraints a SceneKit node to always
    // point towards the camera.
    let billboardConstraint = SCNBillboardConstraint()
    billboardConstraint.freeAxes = SCNBillboardAxis.Y
    markerNode.constraints = [billboardConstraint]

    return markerNode
  }


  // MARK: - SkyNet starts here!!!

  func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {

  }

  func startCoreMLVisionLoop() {

  }

  func evaluateCurrentFrame() {
    // Get the image from the current frame.

    // Use the image to make an image request handler
    // and then pass it to Core ML to see if can guess
    // what it is.
    
  }

  func classificationCompleteHandler(request: VNRequest, error: Error?) {
    // Eliminate any error cases.
    guard error == nil else {
      print("Error: " + (error?.localizedDescription)!)
      return
    }
    guard let observations = request.results else {
      print("No results")
      return
    }

    // Capture the best guess.

//    // Display the top 3 guesses in both the debug console and the observations label.
//    let top3Guesses = observations[0...2]
//      .compactMap { $0 as? VNClassificationObservation }
//      .map { "\($0.identifier) \(String(format:" [%1.0f%%]", $0.confidence * 100))" }
//      .joined(separator: "\n")
//    print(top3Guesses)
//    print("--")
//    DispatchQueue.main.async {
//      self.observationsLabel.text = top3Guesses
//    }

  }
    
}


extension UIFont {

  func withTraits(traits: UIFontDescriptorSymbolicTraits...) -> UIFont {
    let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
    return UIFont(descriptor: descriptor!, size: 0)
  }

}
