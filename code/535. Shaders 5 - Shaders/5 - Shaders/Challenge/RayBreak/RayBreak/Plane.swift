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

  var vertices: [Vertex] = [
    Vertex(position: float3( -1, 1, 0),// V0
      color: float4(1, 0, 0, 1)),
    Vertex(position: float3( -1, -1, 0),// V1
      color: float4(0, 1, 0, 1)),
    Vertex(position: float3( 1, -1, 0), // V2
      color: float4(0, 0, 1, 1)),
    Vertex(position: float3( 1, 1, 0), // V3
      color: float4(1, 0, 1, 1))
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
 
  // Renderable
  var pipelineState: MTLRenderPipelineState!
  var fragmentFunctionName: String = "fragment_shader"
  var vertexFunctionName: String = "vertex_shader"
  
  var vertexDescriptor: MTLVertexDescriptor {
    let vertexDescriptor = MTLVertexDescriptor()
    
    vertexDescriptor.attributes[0].format = .float3
    vertexDescriptor.attributes[0].offset = 0
    vertexDescriptor.attributes[0].bufferIndex = 0
    
    vertexDescriptor.attributes[1].format = .float4
    vertexDescriptor.attributes[1].offset = MemoryLayout<float3>.stride
    vertexDescriptor.attributes[1].bufferIndex = 0
    
    vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
    
    return vertexDescriptor
  }
  
  init(device: MTLDevice) {
    super.init()
    buildBuffers(device: device)
    pipelineState = buildPipelineState(device: device)
  }
  
  private func buildBuffers(device: MTLDevice) {
    vertexBuffer = device.makeBuffer(bytes: vertices,
                                     length: vertices.count *
                                      MemoryLayout<Vertex>.stride,
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
    
    commandEncoder.setRenderPipelineState(pipelineState)
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

extension Plane: Renderable {
}

