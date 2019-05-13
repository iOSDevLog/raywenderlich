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

class Instance: Node {
  var model: Model
  
  var nodes = [Node]()
  var instanceConstants = [ModelConstants]()
  
  var modelConstants = ModelConstants()
  
  var instanceBuffer: MTLBuffer?
  
  // Renderable
  var pipelineState: MTLRenderPipelineState!
  var vertexFunctionName: String = "vertex_instance_shader"
  
  var fragmentFunctionName: String
  var vertexDescriptor: MTLVertexDescriptor
  
  init(device: MTLDevice, modelName: String, instances: Int) {
    model = Model(device: device, modelName: modelName)
    vertexDescriptor = model.vertexDescriptor
    fragmentFunctionName = model.fragmentFunctionName
    
    super.init()
    name = modelName
    create(instances: instances)
    makeBuffer(device: device)
    pipelineState = buildPipelineState(device: device)
  }
  
  func create(instances: Int) {
    for i in 0..<instances {
      let node = Node()
      node.name = "Instance \(i)"
      nodes.append(node)
      instanceConstants.append(ModelConstants())
    }
  }
  
  func remove(instance: Int) {
    nodes.remove(at: instance)
    instanceConstants.remove(at: instance)
  }
  
  func makeBuffer(device: MTLDevice) {
    instanceBuffer = device.makeBuffer(length: instanceConstants.count * MemoryLayout<ModelConstants>.stride,
                                       options: [])
    instanceBuffer?.label = "Instance Buffer"
  }
  

}

extension Instance: Renderable {
  func doRender(commandEncoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
    guard let instanceBuffer = instanceBuffer,
      nodes.count > 0 else { return }
    var pointer = instanceBuffer.contents().bindMemory(to: ModelConstants.self,
                                                       capacity: nodes.count)
    for node in nodes {
      pointer.pointee.modelViewMatrix = matrix_multiply(modelViewMatrix, node.modelMatrix)
      pointer.pointee.materialColor = node.materialColor
      pointer.pointee.normalMatrix = matrix_multiply(modelViewMatrix, node.modelMatrix).upperLeft3x3()
      pointer.pointee.shininess = node.shininess
      pointer.pointee.specularIntensity = node.specularIntensity
      pointer = pointer.advanced(by: 1)
    }
    commandEncoder.setFragmentTexture(model.texture, at: 0)
    commandEncoder.setRenderPipelineState(pipelineState)
    commandEncoder.setVertexBuffer(instanceBuffer, offset: 0, at: 1)
    guard let meshes = model.meshes as? [MTKMesh],
      meshes.count > 0 else { return }
    for mesh in meshes {
      let vertexBuffer = mesh.vertexBuffers[0]
      commandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, at: 0)
      for submesh in mesh.submeshes {
        commandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                             indexCount: submesh.indexCount,
                                             indexType: submesh.indexType,
                                             indexBuffer: submesh.indexBuffer.buffer,
                                             indexBufferOffset: submesh.indexBuffer.offset,
                                             instanceCount: nodes.count)
      }
    }
  }
}
