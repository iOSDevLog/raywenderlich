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

class Model: Node {
  var meshes: [AnyObject]?
  
  // Texturable
  var texture: MTLTexture?
  
  // Renderable
  var pipelineState: MTLRenderPipelineState!
  var fragmentFunctionName: String = "fragment_color"
  var vertexFunctionName: String = "vertex_shader"
  var modelConstants = ModelConstants()
  
  var vertexDescriptor: MTLVertexDescriptor {
    let vertexDescriptor = MTLVertexDescriptor()
    
    vertexDescriptor.attributes[0].format = .float3
    vertexDescriptor.attributes[0].offset = 0
    vertexDescriptor.attributes[0].bufferIndex = 0
    
    vertexDescriptor.attributes[1].format = .float4
    vertexDescriptor.attributes[1].offset = MemoryLayout<Float>.stride * 3
    vertexDescriptor.attributes[1].bufferIndex = 0
    
    vertexDescriptor.attributes[2].format = .float2
    vertexDescriptor.attributes[2].offset = MemoryLayout<Float>.stride * 7
    vertexDescriptor.attributes[2].bufferIndex = 0
    
    vertexDescriptor.attributes[3].format = .float3
    vertexDescriptor.attributes[3].offset = MemoryLayout<Float>.stride * 9
    vertexDescriptor.attributes[3].bufferIndex = 0

    vertexDescriptor.layouts[0].stride = MemoryLayout<Float>.stride * 12
    
    return vertexDescriptor
  }
  
  init(device:MTLDevice, modelName: String) {
    super.init()
    name = modelName
    loadModel(device: device, modelName: modelName)
    
    let imageName = modelName + ".png"
    if let texture = setTexture(device: device, imageName: imageName) {
      self.texture = texture
      fragmentFunctionName = "lit_textured_fragment"
    }
    pipelineState = buildPipelineState(device: device)
  }
  
  func loadModel(device: MTLDevice, modelName: String) {
    guard let assetURL = Bundle.main.url(forResource: modelName, withExtension: "obj") else {
      fatalError("Asset \(modelName) does not exist.")
    }
    let descriptor = MTKModelIOVertexDescriptorFromMetal(vertexDescriptor)
    
    let attributePosition = descriptor.attributes[0] as! MDLVertexAttribute
    attributePosition.name = MDLVertexAttributePosition
    descriptor.attributes[0] = attributePosition
    
    let attributeColor = descriptor.attributes[1] as! MDLVertexAttribute
    attributeColor.name = MDLVertexAttributeColor
    descriptor.attributes[1] = attributeColor
    
    let attributeTexture = descriptor.attributes[2] as! MDLVertexAttribute
    attributeTexture.name = MDLVertexAttributeTextureCoordinate
    descriptor.attributes[2] = attributeTexture
    
    let attributeNormal = descriptor.attributes[3] as! MDLVertexAttribute
    attributeNormal.name = MDLVertexAttributeNormal
    descriptor.attributes[3] = attributeNormal
    
    let bufferAllocator = MTKMeshBufferAllocator(device: device)
    let asset = MDLAsset(url: assetURL,
                         vertexDescriptor: descriptor,
                         bufferAllocator: bufferAllocator)
    
    do {
      meshes = try MTKMesh.newMeshes(from: asset,
                                     device: device,
                                     sourceMeshes: nil)
    } catch {
      print("mesh error")
    }
  }
}

extension Model: Renderable {
  func doRender(commandEncoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
    modelConstants.modelViewMatrix = modelViewMatrix
    modelConstants.materialColor = materialColor
    commandEncoder.setVertexBytes(&modelConstants,
                                  length: MemoryLayout<ModelConstants>.stride,
                                  at: 1)
    if texture != nil {
      commandEncoder.setFragmentTexture(texture, at: 0)
    }
    commandEncoder.setRenderPipelineState(pipelineState)
    guard let meshes = meshes as? [MTKMesh],
      meshes.count > 0 else { return }
    for mesh in meshes {
      let vertexBuffer = mesh.vertexBuffers[0]
      commandEncoder.setVertexBuffer(vertexBuffer.buffer,
                                     offset: vertexBuffer.offset,
                                     at: 0)
      for submesh in mesh.submeshes {
        commandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                             indexCount: submesh.indexCount,
                                             indexType: submesh.indexType,
                                             indexBuffer: submesh.indexBuffer.buffer,
                                             indexBufferOffset: submesh.indexBuffer.offset)
      }
    }
  }
}

extension Model: Texturable {}


