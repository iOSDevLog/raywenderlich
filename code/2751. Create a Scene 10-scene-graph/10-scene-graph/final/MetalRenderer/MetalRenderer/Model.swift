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
  
  let mdlMeshes: [MDLMesh]
  let mtkMeshes: [MTKMesh]
  
  init(name: String) {
    let assetUrl = Bundle.main.url(forResource: name, withExtension: "obj")
    let allocator = MTKMeshBufferAllocator(device: Renderer.device)
    
    let vertexDescriptor = MDLVertexDescriptor.defaultVertexDescriptor()
    let asset = MDLAsset(url: assetUrl, vertexDescriptor: vertexDescriptor, bufferAllocator: allocator)
    
    let (mdlMeshes, mtkMeshes) = try! MTKMesh.newMeshes(asset: asset, device: Renderer.device)
    self.mdlMeshes = mdlMeshes
    self.mtkMeshes = mtkMeshes
    
    super.init()
    self.name = name
  }
}

extension Model: Renderable {
  func render(commandEncoder: MTLRenderCommandEncoder, uniforms vertex: Uniforms) {
    var uniforms = vertex

    uniforms.modelMatrix = worldMatrix
    commandEncoder.setVertexBytes(&uniforms,
                                  length: MemoryLayout<Uniforms>.stride,
                                  index: 21)
    
    for mtkMesh in mtkMeshes {
      for vertexBuffer in mtkMesh.vertexBuffers {
        
        commandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: 0, index: 0)
        
        var colorIndex: Int = 0
        
        for submesh in mtkMesh.submeshes {
          commandEncoder.setVertexBytes(&colorIndex,
                                        length: MemoryLayout<Int>.stride,
                                        index: 11)
          commandEncoder.drawIndexedPrimitives(type: .triangle,
                                               indexCount: submesh.indexCount,
                                               indexType: submesh.indexType,
                                               indexBuffer: submesh.indexBuffer.buffer,
                                               indexBufferOffset: submesh.indexBuffer.offset)
          colorIndex += 1
        }
      }
    }

  }
}

