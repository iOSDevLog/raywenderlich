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

class Plane: Node {
  var vertices: [Float] = [
    -1,  1, 0,   // V0
    -1, -1, 0,   // V1
     1, -1, 0,   // V2
     1,  1, 0,   // V3
  ]
  
  var indices: [UInt16] = [
    0, 1, 2,
    2, 3, 0
  ]
  
  var vertexBuffer: MTLBuffer?
  var indexBuffer: MTLBuffer?
  
  var time: Float = 0
  
  struct Constants {
    var animateBy: Float = 0.0
  }
  
  var constants = Constants()
 
  init(device: MTLDevice) {
    super.init()
    buildBuffers(device: device)
  }
  
  private func buildBuffers(device: MTLDevice) {
    vertexBuffer = device.makeBuffer(bytes: vertices,
                                     length: vertices.count * MemoryLayout<Float>.size,
                                     options: [])
    indexBuffer = device.makeBuffer(bytes: indices,
                                    length: indices.count * MemoryLayout<UInt16>.size,
                                    options: [])
  }
  
  override func render(commandEncoder: MTLRenderCommandEncoder,
                       deltaTime: Float) {
    super.render(commandEncoder: commandEncoder,
                 deltaTime: deltaTime)
    guard let indexBuffer = indexBuffer else { return }
    
    time += deltaTime
    
    let animateBy = abs(sin(time)/2 + 0.5)
    constants.animateBy = animateBy
    
    commandEncoder.setVertexBuffer(vertexBuffer,
                                   offset: 0, at: 0)
    commandEncoder.setVertexBytes(&constants,
                                  length: MemoryLayout<Constants>.stride,
                                  at: 1)
    
    commandEncoder.drawIndexedPrimitives(type: .triangle,
                                         indexCount: indices.count,
                                         indexType: .uint16,
                                         indexBuffer: indexBuffer,
                                         indexBufferOffset: 0)
  }

  

}

