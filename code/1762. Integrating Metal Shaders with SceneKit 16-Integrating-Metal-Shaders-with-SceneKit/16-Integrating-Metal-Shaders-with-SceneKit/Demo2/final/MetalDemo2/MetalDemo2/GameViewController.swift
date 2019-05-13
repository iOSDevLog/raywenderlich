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
    
    box.shaderModifiers = [.surface:
      """
      float2 st = _surface.diffuseTexcoord.xy;
      
      st.y = 1.0 - st.y;
      float2 ts = float2(st.x, 0.82 - st.y);
      
      float2 st2 = (st * 2.0 - 1.0) * 2.0;
      float triSDF1 = max(abs(st2.x) * 0.866025 + st2.y * 0.5, -st2.y * 0.5);
      float triSDFFill1 = 1.0 - step(0.7, triSDF1);
      
      float2 ts2 = (ts * 2.0 - 1.0) * 2.0;
      float triSDF2 = max(abs(ts2.x) * 0.866025 + ts2.y * 0.5, -ts2.y * 0.5);
      float triSDFFill2 = 1.0 - step(0.36, triSDF2);
      
      float fillColor = triSDFFill1;
      fillColor -= triSDFFill2;
      
      _surface.diffuse = mix(float4(1.0), float4(0.0), fillColor);
      """
      
    ]
    
    let geometryNode = SCNNode(geometry: box)
    scnScene.rootNode.addChildNode(geometryNode)
  }
}
