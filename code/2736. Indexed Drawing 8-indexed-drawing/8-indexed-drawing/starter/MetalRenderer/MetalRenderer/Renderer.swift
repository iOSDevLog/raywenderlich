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

class Renderer: NSObject {
  static var device: MTLDevice!
  let commandQueue: MTLCommandQueue
  static var library: MTLLibrary!
  let pipelineState: MTLRenderPipelineState
  
  let positionArray: [float4] = [
    float4(-0.5, -0.2, 0, 1),
    float4(0.2, -0.2, 0, 1),
    float4(0, 0.5, 0, 1),
    float4(0, 0.5, 0, 1),
    float4(0.2, -0.2, 0, 1),
    float4(0.7, 0.7, 0, 1)
  ]
  
  let colorArray: [float3] = [
    float3(1, 0, 0),
    float3(0, 1, 0),
    float3(0, 0, 1),
    float3(0, 0, 1),
    float3(0, 1, 0),
    float3(1, 0, 1)
  ]

  let positionBuffer: MTLBuffer
  let colorBuffer: MTLBuffer
  
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
    
    let positionLength = MemoryLayout<float4>.stride * positionArray.count
    positionBuffer = device.makeBuffer(bytes: positionArray, length: positionLength, options: [])!
    let colorLength = MemoryLayout<float3>.stride * colorArray.count
    colorBuffer = device.makeBuffer(bytes: colorArray, length: colorLength, options: [])!
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
    
    timer += 0.05
    var currentTime = sin(timer)
    
    commandEncoder.setVertexBytes(&currentTime,
                                  length: MemoryLayout<Float>.stride,
                                  index: 2)
    commandEncoder.setRenderPipelineState(pipelineState)
    
    commandEncoder.setVertexBuffer(positionBuffer, offset: 0, index: 0)
    commandEncoder.setVertexBuffer(colorBuffer, offset: 0, index: 1)
    
    // draw call
    commandEncoder.drawPrimitives(type: .triangle,
                                  vertexStart: 0,
                                  vertexCount: 6)
    commandEncoder.endEncoding()
    
    commandBuffer.present(drawable)
    commandBuffer.commit()
    
  }
}
