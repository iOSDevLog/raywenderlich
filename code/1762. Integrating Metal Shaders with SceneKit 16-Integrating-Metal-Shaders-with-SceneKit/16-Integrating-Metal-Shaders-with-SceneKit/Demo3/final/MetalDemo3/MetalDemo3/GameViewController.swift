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
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
  
  // Properties
  var scnView: SCNView!
  var scnScene: SCNScene!
  var cameraNode: SCNNode!
  
  // Function Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupScene()
    setupCamera()
    addBox()
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  // Setup Functions
  func setupView() {
    scnView = self.view as! SCNView
    scnView.showsStatistics = true
    scnView.allowsCameraControl = true
    scnView.autoenablesDefaultLighting = true
  }
  
  func setupScene() {
    scnScene = SCNScene()
    scnView.scene = scnScene
    scnScene.background.contents = UIColor.purple
  }
  
  func setupCamera() {
    cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    cameraNode.position = SCNVector3(x: 0, y:0, z: 10)
    scnScene.rootNode.addChildNode(cameraNode)
  }
  
  func addBox() {
    let box = SCNBox(width: 2.0, height: 2.0, length: 2.0, chamferRadius: 0.0)
    
    let program = SCNProgram()
    //        program.vertexFunctionName = "redVertex"
    //        program.fragmentFunctionName = "redFragment"
    program.vertexFunctionName = "brickVertex"
    program.fragmentFunctionName = "brickFragment"
    
    let material = SCNMaterial()
    material.program = program
    
    box.materials = [material]
    
    let geometryNode = SCNNode(geometry: box)
    scnScene.rootNode.addChildNode(geometryNode)
  }
  
}
