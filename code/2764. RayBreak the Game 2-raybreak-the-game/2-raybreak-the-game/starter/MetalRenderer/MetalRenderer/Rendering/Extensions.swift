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

extension MTLVertexDescriptor {
  static func defaultVertexDescriptor() -> MTLVertexDescriptor {
    let vertexDescriptor = MTLVertexDescriptor()
    
    vertexDescriptor.attributes[0].format = .float3
    vertexDescriptor.attributes[0].offset = 0
    vertexDescriptor.attributes[0].bufferIndex = 0
    
    vertexDescriptor.attributes[1].format = .float3
    vertexDescriptor.attributes[1].offset = MemoryLayout<float3>.stride
    vertexDescriptor.attributes[1].bufferIndex = 0
    
    vertexDescriptor.attributes[2].format = .float2
    vertexDescriptor.attributes[2].offset = MemoryLayout<float3>.stride * 2
    vertexDescriptor.attributes[2].bufferIndex = 0
    
    let stride = MemoryLayout<float3>.stride * 2 + MemoryLayout<float2>.stride

    vertexDescriptor.layouts[0].stride = stride
    return vertexDescriptor
  }
}

extension MDLVertexDescriptor {
  static func defaultVertexDescriptor() -> MDLVertexDescriptor {
    let vertexDescriptor = MTKModelIOVertexDescriptorFromMetal(MTLVertexDescriptor.defaultVertexDescriptor())
    let attributePosition = vertexDescriptor.attributes[0] as! MDLVertexAttribute
    attributePosition.name = MDLVertexAttributePosition
    let attributeNormal = vertexDescriptor.attributes[1] as! MDLVertexAttribute
    attributeNormal.name = MDLVertexAttributeNormal
    let attributeUV = vertexDescriptor.attributes[2] as! MDLVertexAttribute
    attributeUV.name = MDLVertexAttributeTextureCoordinate

    return vertexDescriptor
  }
}

#if os(macOS)
extension Scene {
  @objc func keyDown(key: Int, isARepeat: Bool) -> Bool {
    // override this
    return false
  }
  
  @objc func keyUp(key: Int) -> Bool {
    // override this
    return false
  }
  
  @objc func click(location: float2) {
    // override
  }
}

extension ViewController {
  func addKeyboardMonitoring() {
    NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
      if self.keyDown(with: $0) {
        return nil
      } else {
        return $0
      }
    }
    NSEvent.addLocalMonitorForEvents(matching: .keyUp) {
      if self.keyUp(with: $0) {
        return nil
      } else {
        return $0
      }
    }
  }
  
  func keyDown(with event: NSEvent)-> Bool {
    guard let window = self.view.window,
      let scene = scene,
      NSApplication.shared.keyWindow === window
      else {
        return false
    }
    return scene.keyDown(key: Int(event.keyCode), isARepeat: event.isARepeat)
  }
  
  func keyUp(with event: NSEvent) -> Bool {
    guard let window = self.view.window,
      let scene = scene,
      NSApplication.shared.keyWindow === window else {
        return false
    }
    return scene.keyUp(key: Int(event.keyCode))
  }
  
  @objc func handleClick(gesture: NSClickGestureRecognizer) {
    let location = gesture.location(in: metalView)
    scene?.click(location: float2(Float(location.x), Float(location.y)))
  }
}
#endif
