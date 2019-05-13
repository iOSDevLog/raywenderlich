/// Copyright (c) 2019 Razeware LLC
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

import Foundation
import MetalKit

class Model: Node {
  
  let meshes: [Mesh]
  
  init(name: String) {
    let assetUrl = Bundle.main.url(forResource: name, withExtension: "obj")
    let allocator = MTKMeshBufferAllocator(device: Renderer.device)
    
    let vertexDescriptor = MDLVertexDescriptor.defaultVertexDescriptor()
    let asset = MDLAsset(url: assetUrl, vertexDescriptor: vertexDescriptor, bufferAllocator: allocator)
    asset.loadTextures()
    
    let (mdlMeshes, mtkMeshes) = try! MTKMesh.newMeshes(asset: asset, device: Renderer.device)
    meshes = zip(mdlMeshes, mtkMeshes).map {
      Mesh(mdlMesh: $0.0, mtkMesh: $0.1)
    }
    
    super.init()
    self.name = name
    self.boundingBox = mdlMeshes[0].boundingBox
  }
  
  func render(commandEncoder: MTLRenderCommandEncoder, submesh: Submesh) {
    let mtkSubmesh = submesh.mtkSubmesh
    commandEncoder.drawIndexedPrimitives(type: .triangle,
                                         indexCount: mtkSubmesh.indexCount,
                                         indexType: mtkSubmesh.indexType,
                                         indexBuffer: mtkSubmesh.indexBuffer.buffer,
                                         indexBufferOffset: mtkSubmesh.indexBuffer.offset)
  }
}

extension Model: Renderable {

  func render(commandEncoder: MTLRenderCommandEncoder,
              uniforms vertex: Uniforms,
              fragmentUniforms fragment: FragmentUniforms) {
    var uniforms = vertex
    var fragmentUniforms = fragment

    uniforms.modelMatrix = worldMatrix
    commandEncoder.setVertexBytes(&uniforms,
                                  length: MemoryLayout<Uniforms>.stride,
                                  index: 21)
    commandEncoder.setFragmentBytes(&fragmentUniforms,
                                   length: MemoryLayout<FragmentUniforms>.stride,
                                   index: 22)
    
    for mesh in meshes {
      for vertexBuffer in mesh.mtkMesh.vertexBuffers {
        
        commandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: 0, index: 0)
        
        for submesh in mesh.submeshes {
          var material = submesh.material
          commandEncoder.setFragmentBytes(&material,
                                          length: MemoryLayout<Material>.stride,
                                          index: 11)
          commandEncoder.setFragmentTexture(submesh.textures.baseColor, index: 0)
          commandEncoder.setRenderPipelineState(submesh.pipelineState)
          
          render(commandEncoder: commandEncoder, submesh: submesh)
        }
      }
    }

  }
}