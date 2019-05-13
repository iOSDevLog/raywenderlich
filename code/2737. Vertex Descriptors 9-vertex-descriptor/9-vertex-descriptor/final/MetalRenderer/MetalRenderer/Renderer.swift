//
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

struct Vertex {
  let position: float3
  let color: float3
}

class Renderer: NSObject {
  static var device: MTLDevice!
  let commandQueue: MTLCommandQueue
  static var library: MTLLibrary!
  let pipelineState: MTLRenderPipelineState
  
  let vertices: [Vertex] = [
    Vertex(position: float3(-0.5, -0.2, 0), color: float3(1, 0, 0)),
    Vertex(position: float3(0.2, -0.2, 0), color: float3(0, 1, 0)),
    Vertex(position: float3(0, 0.5, 0), color: float3(0, 0, 1)),
    Vertex(position: float3(0.7, 0.7, 0), color: float3(1, 0, 1))
  ]
  
  let indexArray: [uint16] = [
    0, 1, 2,
    2, 1, 3
  ]

  let vertexBuffer: MTLBuffer
  let indexBuffer: MTLBuffer
  
  var timer: Float = 0
  
  init(view: MTKView) {
    guard let device = MTLCreateSystemDefaultDevice(),
      let commandQueue = device.makeCommandQueue() else {
        fatalError("Unable to connect to GPU")
    }
    Renderer.device = device
    self.commandQueue = commandQueue
    Renderer.library = device.makeDefaultLibrary()!
    pipelineState = Renderer.createPipelineState()

    let vertexLength = MemoryLayout<Vertex>.stride * vertices.count
    vertexBuffer = device.makeBuffer(bytes: vertices,
                                     length: vertexLength,
                                     options: [])!
    
    let indexLength = MemoryLayout<uint16>.stride * indexArray.count
    indexBuffer = device.makeBuffer(bytes: indexArray, length: indexLength, options: [])!
    
    super.init()
  }
  
  static func createPipelineState() -> MTLRenderPipelineState {
    let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
    
    // pipeline state properties
    pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
    let vertexFunction = Renderer.library.makeFunction(name: "vertex_main")
    let fragmentFunction = Renderer.library.makeFunction(name: "fragment_main")
    pipelineStateDescriptor.vertexFunction = vertexFunction
    pipelineStateDescriptor.fragmentFunction = fragmentFunction
    pipelineStateDescriptor.vertexDescriptor = MTLVertexDescriptor.defaultVertexDescriptor()
    
    return try! Renderer.device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
  }
}

extension Renderer: MTKViewDelegate {
  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    
  }
  
  func draw(in view: MTKView) {
    guard let commandBuffer = commandQueue.makeCommandBuffer(),
      let drawable = view.currentDrawable,
    let descriptor = view.currentRenderPassDescriptor,
    let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor) else {
        return
    }
    
    commandEncoder.setRenderPipelineState(pipelineState)
    
    commandEncoder.setVertexBuffer(vertexBuffer,
                                   offset: 0, index: 0)
    
    // draw call
    commandEncoder.drawIndexedPrimitives(type: .triangle,
                                         indexCount: indexArray.count,
                                         indexType: .uint16,
                                         indexBuffer: indexBuffer,
                                         indexBufferOffset: 0)
    
    
    commandEncoder.endEncoding()
    
    commandBuffer.present(drawable)
    commandBuffer.commit()
    
  }
}
