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

class LightingScene: Scene {

  let mushroom: Model
  var previousTouchLocation: CGPoint = .zero
  
  override init(device: MTLDevice, size: CGSize) {
    mushroom = Model(device: device, modelName: "mushroom")
    
    super.init(device: device, size: size)
    
    mushroom.position.y = -1
    add(childNode: mushroom)
    
    light.color = float3(1, 1, 1)
    light.ambientIntensity = 0.2
    light.diffuseIntensity = 0.8
    light.direction = float3(0, 0, -1)
  }
  
  override func update(deltaTime: Float) {
  }
  
  override func touchesBegan(_ view: UIView, touches: Set<UITouch>,
                             with event: UIEvent?) {
    guard let touch = touches.first else { return }
    previousTouchLocation = touch.location(in: view)
  }
  
  override func touchesMoved(_ view: UIView, touches: Set<UITouch>,
                             with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let touchLocation = touch.location(in: view)
    
    let delta = CGPoint(x: previousTouchLocation.x - touchLocation.x,
                        y: previousTouchLocation.y - touchLocation.y)
    let sensitivity: Float = 0.01
    mushroom.rotation.x += Float(delta.y) * sensitivity
    mushroom.rotation.y += Float(delta.x) * sensitivity
    previousTouchLocation = touchLocation
  }
}
