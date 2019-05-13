/**
 * Copyright (c) 2016 Razeware LLC
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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import MetalKit

enum Colors {
  static let wenderlichGreen = MTLClearColor(red: 0.0,
                                             green: 0.4,
                                             blue: 0.21,
                                             alpha: 1.0)
  static let skyBlue = MTLClearColor(red: 0.66,
                                     green: 0.9,
                                     blue: 0.96,
                                     alpha: 1.0)
}

class ViewController: UIViewController {

  var metalView: MTKView {
      return view as! MTKView
  }
  
  var renderer: Renderer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    metalView.device = MTLCreateSystemDefaultDevice()
    guard let device = metalView.device else {
      fatalError("Device not created. Run on a physical device")
    }
    
    metalView.clearColor =  Colors.wenderlichGreen
    renderer = Renderer(device: device)
    renderer?.scene = GameScene(device: device, size: view.bounds.size)
    metalView.delegate = renderer
    
  }
  
  override var prefersStatusBarHidden: Bool { return true }

  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    renderer?.scene?.touchesBegan(view, touches:touches,
                                  with: event)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    renderer?.scene?.touchesMoved(view, touches: touches,
                                  with: event)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    renderer?.scene?.touchesEnded(view, touches: touches,
                                  with: event)
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>,
                                 with event: UIEvent?) {
    renderer?.scene?.touchesCancelled(view, touches: touches,
                                      with: event)
  }
}



