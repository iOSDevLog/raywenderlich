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

import ARKit
import SceneKit
import UIKit

class ViewController: UIViewController, ARSCNViewDelegate {

  // MARK: - Properties
  // ==================

  // UI element properties
  // ---------------------
  @IBOutlet var sceneView: ARSCNView!
  @IBOutlet weak var blurView: UIVisualEffectView!

  // The view controller that displays the status and "restart experience" UI.
  lazy var statusViewController: StatusViewController = {
    return childViewControllers.lazy.compactMap({ $0 as? StatusViewController }).first!
  }()

  // Artwork names
  // -------------
  let blockedName = "blocked_image"
  let artworkDisplayNames = [
    "boat_on_beach"         : "Boat on Beach",
    "bob_dobbs"             : "J. R. “Bob” Dobbs, Jr.",
    "cat_in_grayscale"      : "Cat",
    "eye"                   : "The Eye",
    "rainbow_hedgehog"      : "Rainbow Hedgehog",
    "starry_night"          : "The Starry Night",
    "still_life_with_apples": "Still Life with Apples",
    ]

  // AR and SceneView update properties
  // ----------------------------------
  let config = ARWorldTrackingConfiguration()
  var isRestartAvailable = true // Prevents the session from restarting while a restart is in progress.

  // A serial queue (also known as a private dispatch queue) that provides thread safety
  // as we make changes to the SceneKit node graph.
  let updateQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).serialSceneKitQueue")


  // MARK: - View initializers / events
  // ==================================

  override func viewDidLoad() {
    super.viewDidLoad()

    sceneView.delegate = self
    sceneView.session.delegate = self

    initGestureRecognizers()

    startARSession()

    // Hook up status view controller callback(s).
    statusViewController.restartExperienceHandler = { [unowned self] in
      self.restartExperience()
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Prevent the screen from being dimmed to avoid interuppting the AR experience.
    // Doing this *will* cause the battery to be used up more quickly.
    UIApplication.shared.isIdleTimerDisabled = true

    startARSession()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    sceneView.session.pause()
  }


  // MARK: - Touch response
  // ======================

  func initGestureRecognizers() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
    sceneView.addGestureRecognizer(tapGestureRecognizer)
  }

  @objc func handleScreenTap(sender: UITapGestureRecognizer) {
    let tappedSceneView = sender.view as! ARSCNView
    let tapLocation = sender.location(in: tappedSceneView)
    let tapsOnPlane = tappedSceneView.hitTest(tapLocation, options: nil)
    if !tapsOnPlane.isEmpty {
      let firstObject = tapsOnPlane.first
      if let firstObjectName = firstObject?.node.name {
        if firstObjectName != blockedName {
          performSegue(withIdentifier: "showArtNotes", sender: firstObjectName)
        }
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showArtNotes" {
      if let artNotesViewController = segue.destination as? ArtNotesViewController {
        artNotesViewController.artworkName = sender as! String
      }
    }
  }


  // MARK: - 2D image detection
  // =========================

  func startARSession() {
    // Make sure that we have an AR resource group.


    // Set up the AR configuration.


    // Start the AR session.
    sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])

    statusViewController.scheduleMessage("Look around for art!",
                                         inSeconds: 7.5,
                                         messageType: .contentPlacement)
  }

  func restartExperience() {
    guard isRestartAvailable else { return }
    isRestartAvailable = false

    statusViewController.cancelAllScheduledMessages()

    startARSession()

    // Disable restart for a few seconds in order to give the AR session time to restart.
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
      self.isRestartAvailable = true
    }
  }

  // This delegate method gets called whenever the node corresponding to
  // a new AR anchor is added to the scene.
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    // We only want to deal with image anchors, which encapsulate
    // the position, orientation, and size, of a detected image that matches
    // one of our reference images.
    let isArtImage = true
    var statusMessage = ""

    // Draw the appropriate plane over the image.
    updateQueue.async {
      var planeNode = SCNNode()

      if isArtImage {
        // If the detected artwork is one that we’d like to highlight (and one which we’d
        // like the user to tap to find out more), draw an “artwork” plane and
        // the name of the artwork over the image.

      } else {
        // If the detected artwork is one that we’d like to obscure,
        // draw a “blocker” plane over the image.

      }

      // Rotate the newly-created plane by 90 degrees clockwise around the x-axis
      // so that it’s vertical.


      // Add the plane node to the scene.

    }

    DispatchQueue.main.async {
      self.statusViewController.cancelAllScheduledMessages()
      self.statusViewController.showMessage(statusMessage)
    }
  }

  // Returns false if the image’s name begins with “block_this-”.
  func isArtImage(_ imageName: String) -> Bool {
    let blockThisPrefix = "block_this-"
    guard imageName.count >= blockThisPrefix.count else { return true }

    let endIndex = blockThisPrefix.index(blockThisPrefix.startIndex, offsetBy: blockThisPrefix.count)
    return imageName[..<endIndex] != "block_this-"
  }

  // Create a translucent plane that will overlay the detected artwork,
  // which the user can tap for more information.
  // The plane will flash momentarily when it first appears.
  func createArtworkPlaneNode(withReferenceImage referenceImage: ARReferenceImage,
                              andImageName imageName: String) -> SCNNode {

    // Draw the plane.
    return SCNNode()
  }

  // Create an opaque plane featuring the soothing image of Ray Wenderlich,
  // which will be used to obscure unwanted images.
  // Yes, we’re in “Black Mirror” territory now.
  func createBlockerPlaneNode(withReferenceImage referenceImage: ARReferenceImage,
                              andImageName imageName: String) -> SCNNode {
    // Draw the plane.
    return SCNNode()
  }

  // Create a text node to display the name of an artwork.
  func createArtworkNameNode(withImageName imageName: String) -> SCNNode {
    let textScaleFactor: Float = 0.15
    let textFont = "AvenirNext-BoldItalic"
    let textSize: CGFloat = 0.2
    let textDepth: CGFloat = 0.02

    return SCNNode()
  }

}


extension ViewController: ARSessionDelegate {

  // MARK: - ARSessionDelegate
  // =========================

  func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
    statusViewController.showTrackingQualityInfo(for: camera.trackingState, autoHide: true)

    switch camera.trackingState {
    case .notAvailable, .limited:
      statusViewController.escalateFeedback(for: camera.trackingState, inSeconds: 3.0)
    case .normal:
      statusViewController.cancelScheduledMessage(for: .trackingStateEscalation)
    }
  }

  func session(_ session: ARSession, didFailWithError error: Error) {
    guard error is ARError else { return }

    let errorWithInfo = error as NSError
    let messages = [
      errorWithInfo.localizedDescription,
      errorWithInfo.localizedFailureReason,
      errorWithInfo.localizedRecoverySuggestion
    ]

    // Use compactMap(_:) to remove optional error messages.
    let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")

    DispatchQueue.main.async {
      self.displayErrorMessage(title: "The AR session failed.", message: errorMessage)
    }
  }

  func sessionWasInterrupted(_ session: ARSession) {
    blurView.isHidden = false
    statusViewController.showMessage("""
        SESSION INTERRUPTED
        The session will be reset after the interruption has ended.
        """, autoHide: false)
  }

  func sessionInterruptionEnded(_ session: ARSession) {
    blurView.isHidden = true
    statusViewController.showMessage("RESETTING SESSION")

    restartExperience()
  }

  func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
    return true
  }


  // MARK: - Error handling
  // ======================

  func displayErrorMessage(title: String, message: String) {
    // Blur the background.
    blurView.isHidden = false

    // Present an alert informing about the error that has occurred.
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
      alertController.dismiss(animated: true, completion: nil)
      self.blurView.isHidden = true
      self.startARSession()
    }
    alertController.addAction(restartAction)
    present(alertController, animated: true, completion: nil)
  }

}


// MARK: - Font goodies
// ====================

extension UIFont {

  func withTraits(traits: UIFontDescriptorSymbolicTraits...) -> UIFont {
    let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
    return UIFont(descriptor: descriptor!, size: 0)
  }

}

