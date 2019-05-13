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

class Renderer: NSObject {
  let device: MTLDevice
  let commandQueue: MTLCommandQueue
  
  var vertices: [Float] = [
          0,  1, 0,
         -1, -1, 0,
          1, -1, 0
  ]
  
  var pipelineState: MTLRenderPipelineState?
  var vertexBuffer: MTLBuffer?
  
  init(device: MTLDevice) {
    self.device = device
    commandQueue = device.makeCommandQueue()
    super.init()
    buildModel()
    buildPipelineState()
  }
  
  private func buildModel() {
    vertexBuffer = device.makeBuffer(bytes: vertices,
                                     length: vertices.count * MemoryLayout<Float>.size,
                                     options: [])
  }
  
  private func buildPipelineState() {
    let library = device.newDefaultLibrary()
    let vertexFunction = library?.makeFunction(name: "vertex_shader")
    let fragmentFunction = library?.makeFunction(name: "fragment_shader")
    
    let pipelineDescriptor = MTLRenderPipelineDescriptor()
    pipelineDescriptor.vertexFunction = vertexFunction
    pipelineDescriptor.fragmentFunction = fragmentFunction
    pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
    
    do {
      pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    } catch let error as NSError {
      print("error: \(error.localizedDescription)")
    }
  }
}

extension Renderer: MTKViewDelegate {
  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
  
  func draw(in view: MTKView) {
    guard let drawable = view.currentDrawable,
      let pipelineState = pipelineState,
      let descriptor = view.currentRenderPassDescriptor else { return }
    let commandBuffer = commandQueue.makeCommandBuffer()
    let commandEncoder =
      commandBuffer.makeRenderCommandEncoder(descriptor: descriptor)
    commandEncoder.setRenderPipelineState(pipelineState)
    commandEncoder.setVertexBuffer(vertexBuffer,
                                   offset: 0, at: 0)
    commandEncoder.drawPrimitives(type: .triangle,
                                  vertexStart: 0,
                                  vertexCount: vertices.count)
    commandEncoder.endEncoding()
    commandBuffer.present(drawable)
    commandBuffer.commit()
    
    
  }
}


