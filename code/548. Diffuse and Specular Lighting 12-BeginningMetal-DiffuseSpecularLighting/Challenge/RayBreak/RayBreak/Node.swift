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

class Node {
  var name = "Untitled"
  var materialColor = float4(1)
  var specularIntensity: Float = 1
  var shininess: Float = 1
  
  var children: [Node] = []
  
  var position = float3(0)
  var rotation = float3(0)
  var scale = float3(1)
  
  var modelMatrix: matrix_float4x4 {
    var matrix = matrix_float4x4(translationX: position.x,
                                 y: position.y, z: position.z)
    matrix = matrix.rotatedBy(rotationAngle: rotation.x,
                              x: 1, y: 0, z: 0)
    matrix = matrix.rotatedBy(rotationAngle: rotation.y,
                              x: 0, y: 1, z: 0)
    matrix = matrix.rotatedBy(rotationAngle: rotation.z,
                              x: 0, y: 0, z: 1)
    matrix = matrix.scaledBy(x: scale.x, y: scale.y, z: scale.z)
    return matrix
  }
  
  func add(childNode: Node) {
    children.append(childNode)
  }
  
  func render(commandEncoder: MTLRenderCommandEncoder,
              parentModelViewMatrix: matrix_float4x4) {
    let modelViewMatrix = matrix_multiply(parentModelViewMatrix,
                                          modelMatrix)
    for child in children {
      child.render(commandEncoder: commandEncoder,
                   parentModelViewMatrix: modelViewMatrix)
    }
    
    if let renderable = self as? Renderable {
      commandEncoder.pushDebugGroup(name)
      renderable.doRender(commandEncoder: commandEncoder,
                          modelViewMatrix: modelViewMatrix)
      commandEncoder.popDebugGroup()
    }
  }
}
