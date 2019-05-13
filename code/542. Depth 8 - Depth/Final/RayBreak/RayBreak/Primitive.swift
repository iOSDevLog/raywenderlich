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

class Primitive: Node {
  
  var vertices: [Vertex] = [
  ]
  
  var indices: [UInt16] = [
  ]
  
  var vertexBuffer: MTLBuffer?
  var indexBuffer: MTLBuffer?
  
  var time: Float = 0
  
  var modelConstants = ModelConstants()
  
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
    
    vertexDescriptor.attributes[2].format = .float2
    vertexDescriptor.attributes[2].offset = MemoryLayout<float3>.stride + MemoryLayout<float4>.stride
    vertexDescriptor.attributes[2].bufferIndex = 0
    
    vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
    
    return vertexDescriptor
  }
  
  // Texturable
  var texture: MTLTexture?
  
  var maskTexture: MTLTexture?
  
  init(device: MTLDevice) {
    super.init()
    buildVertices()
    buildBuffers(device: device)
    pipelineState = buildPipelineState(device: device)
  }
  
  init(device: MTLDevice, imageName: String) {
    super.init()
    if let texture = setTexture(device: device, imageName: imageName) {
      self.texture = texture
      fragmentFunctionName = "textured_fragment"
    }
    buildVertices()
    buildBuffers(device: device)
    pipelineState = buildPipelineState(device: device)
  }
  
  init(device: MTLDevice, imageName: String, maskImageName: String) {
    super.init()
    buildVertices()
    buildBuffers(device: device)
    if let texture = setTexture(device: device, imageName: imageName) {
      self.texture = texture
      fragmentFunctionName = "textured_fragment"
    }
    if let maskTexture = setTexture(device: device,
                                    imageName: maskImageName) {
      self.maskTexture = maskTexture
      fragmentFunctionName = "textured_mask_fragment"
    }
    pipelineState = buildPipelineState(device: device)
  }
  
  func buildVertices() {}
  
  private func buildBuffers(device: MTLDevice) {
    vertexBuffer = device.makeBuffer(bytes: vertices,
                                     length: vertices.count *
                                      MemoryLayout<Vertex>.stride,
                                     options: [])
    indexBuffer = device.makeBuffer(bytes: indices,
                                    length: indices.count * MemoryLayout<UInt16>.size,
                                    options: [])
  }
}

extension Primitive: Renderable {
  func doRender(commandEncoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
    guard let indexBuffer = indexBuffer else { return }
    let aspect = Float(750.0/1334.0)
    let projectionMatrix = matrix_float4x4(projectionFov: radians(fromDegrees: 65),
                                           aspect: aspect,
                                           nearZ: 0.1, farZ: 100)
    modelConstants.modelViewMatrix = matrix_multiply(projectionMatrix, modelViewMatrix)
    commandEncoder.setRenderPipelineState(pipelineState)
    commandEncoder.setVertexBuffer(vertexBuffer,
                                   offset: 0, at: 0)
    commandEncoder.setVertexBytes(&modelConstants,
                                  length: MemoryLayout<ModelConstants>.stride,
                                  at: 1)
    commandEncoder.setFragmentTexture(texture, at: 0)
    commandEncoder.setFragmentTexture(maskTexture, at: 1)
    commandEncoder.setFrontFacing(.counterClockwise)
    commandEncoder.setCullMode(.back)
    commandEncoder.drawIndexedPrimitives(type: .triangle,
                                         indexCount: indices.count,
                                         indexType: .uint16,
                                         indexBuffer: indexBuffer,
                                         indexBufferOffset: 0)
  }
}

extension Primitive: Texturable {}


