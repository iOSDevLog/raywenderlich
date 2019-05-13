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

class Scene: Node {
  var device: MTLDevice
  var size: CGSize
  var camera = Camera()
  var sceneConstants = SceneConstants()
  var light = Light()
  
  init(device: MTLDevice, size: CGSize) {
    self.device = device
    self.size = size
    super.init()
    camera.position.z = -6
    add(childNode: camera)
  }
  
  func update(deltaTime: Float) {}
  
  func render(commandEncoder: MTLRenderCommandEncoder,
              deltaTime: Float) {
    update(deltaTime: deltaTime)
    sceneConstants.projectionMatrix = camera.projectionMatrix
    commandEncoder.setFragmentBytes(&light,
                                    length: MemoryLayout<Light>.stride,
                                    at: 3)
    
    commandEncoder.setVertexBytes(&sceneConstants,
                                  length: MemoryLayout<SceneConstants>.stride,
                                  at: 2)
    for child in children {
      child.render(commandEncoder: commandEncoder,
                   parentModelViewMatrix: camera.viewMatrix)
    }
  }
  
  func sceneSizeWillChange(to size: CGSize) {
    camera.aspect = Float(size.width / size.height)
  }
}
