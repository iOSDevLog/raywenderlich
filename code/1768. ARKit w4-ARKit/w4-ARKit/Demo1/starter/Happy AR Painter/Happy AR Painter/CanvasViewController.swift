///// Copyright (c) 2017 Razeware LLC
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

class CanvasViewController: UIViewController, ARSCNViewDelegate {

  @IBOutlet weak var canvas: ARSCNView!
  @IBOutlet weak var paintButton: UIButton!

  internal var brushSettings: BrushSettings!

  // Define AR configuration


  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let customTabBarController = self.tabBarController as! CustomTabBarController
    brushSettings = customTabBarController.brushSettings

    // Set up the AR SceneKit view

  }

  func drawTestShapes() {
    // Draw happy lil’ orange sphere


    // Draw happy lil’ blue box, tilted at a jaunty angle


    // Animate the blue box

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: ARSCNViewDelegate methods
  // ===============================

  // Called every time the augmented reality scene is about to be rendered
  // (ideally, at least 60 times a second).
  func renderer(_ renderer: SCNSceneRenderer,
                willRenderScene scene: SCNScene,
                atTime time: TimeInterval) {

    // Get the device’s location, orientation, and position


    // By putting this code in a “DispatchQueue.main.async” block,
    // we ensure that this code gets executed in the main queue.
    // We need to do this because we’re removing nodes from the scene
    // and checking the state of the “Paint” button, both of which
    // need to be done in the main queue.
    DispatchQueue.main.async {
      // Create the brush and erase any old cursor shapes

      if self.paintButton.isHighlighted {
        // The user IS pressing the “Paint” button
        // Give the shape a shine and set it to the selected color



        if self.brushSettings.isSpinning {
          // Spin the shape continuously around the y-axis
          
        }
      } else {
        // The user IS NOT pressing the “Paint” button
        // Set the shape to the cursor color and name

      }

      // Paint the shape to the screen

    }
  }

  // MARK: Node creation methods
  // ===========================

  // Erase any nodes with the given name.
  func eraseNodes(named nameToErase: String) {
    self.canvas.scene.rootNode.enumerateChildNodes { (node, _) in
      if node.name == nameToErase {
        node.removeFromParentNode()
      }
    }
  }

  // Create a node based on the current brush settings
  // and the camera’s current position.
  func createBrush(brushShape: BrushSettings.Shape,
                   brushSize: CGFloat,
                   position: SCNVector3) -> SCNNode {
    let minSize: CGFloat = 0.02
    let maxSize: CGFloat = 0.5
    let shapeSize = minSize + brushSize * (minSize + maxSize)

    let brush: SCNNode!

    switch brushShape {
      case .box:
        brush = SCNNode(geometry: SCNBox(width: shapeSize,
                                         height: shapeSize,
                                         length: shapeSize,
                                         chamferRadius: 0))
      case .capsule:
        brush = SCNNode(geometry: SCNCapsule(capRadius: shapeSize / 8,
                                             height: shapeSize))
        brush.eulerAngles = SCNVector3(0, 0, Double.pi / 2)
      case .cone:
        brush = SCNNode(geometry: SCNCone(topRadius: 0,
                                          bottomRadius: shapeSize / 8,
                                          height: shapeSize))
        brush.eulerAngles = SCNVector3(0, 0, Double.pi / 2)
      case .cylinder:
        brush = SCNNode(geometry: SCNCylinder(radius: shapeSize / 8,
                                              height: shapeSize))
        brush.eulerAngles = SCNVector3(0, 0, Double.pi / 2)
      case .pyramid:
        brush = SCNNode(geometry: SCNPyramid(width: shapeSize,
                                             height: shapeSize,
                                             length: shapeSize))
      case .sphere:
        brush = SCNNode(geometry: SCNSphere(radius: shapeSize / 2))
      case .torus:
        brush = SCNNode(geometry: SCNTorus(ringRadius: shapeSize / 2,
                                           pipeRadius: shapeSize / 8))
        brush.eulerAngles = SCNVector3(Double.pi / 2, 0, 0)
      case .tube:
        brush = SCNNode(geometry: SCNTube(innerRadius: shapeSize / 10,
                                          outerRadius: shapeSize / 8,
                                          height: shapeSize))
        brush.eulerAngles = SCNVector3(0, 0, Double.pi / 2)
    }

    brush.position = position
    return brush
  }

}


// MARK: Utility methods
// =====================

// Extend the "+" operator so that it can add two SCNVector3s together.
func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
  return SCNVector3(left.x + right.x,
                    left.y + right.y,
                    left.z + right.z)
}
