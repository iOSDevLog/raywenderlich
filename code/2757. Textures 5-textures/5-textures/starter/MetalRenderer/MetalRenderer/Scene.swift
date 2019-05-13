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

class Scene {
  var rootNode = Node()
  var renderables: [Renderable] = []
  
  var sceneSize: CGSize
  
  let camera = ArcballCamera()
  var uniforms = Uniforms()
  var fragmentUniforms = FragmentUniforms()
  
  init(sceneSize: CGSize) {

    self.sceneSize = sceneSize
    sceneSizeWillChange(to: sceneSize)
    setupScene()
  }

  func updateScene(deltaTime: Float) {
    // override this to update the scene
  }
  
  final func update(deltaTime: Float) {
    updateScene(deltaTime: deltaTime)
    uniforms.projectionMatrix = camera.projectionMatrix
    uniforms.viewMatrix = camera.viewMatrix
    fragmentUniforms.cameraPosition = camera.position
  }

  final func add(node: Node, parent: Node? = nil, render: Bool = true) {
    if let parent = parent {
      parent.add(childNode: node)
    } else {
      rootNode.add(childNode: node)
    }
    
    if render, let renderable = node as? Renderable {
      renderables.append(renderable)
    }
  }
  
  final func remove(node: Node) {
    if let parent = node.parent {
      parent.remove(childNode: node)
    } else {
      for child in node.children {
        child.parent = nil
      }
      node.children = []
    }
    
    if node is Renderable,
      let index = renderables.index(where: { $0 as? Node === node }) {
      renderables.remove(at: index)
    }
  }

  func setupScene() {
    // override this to add objects to the scene
  }
  
  func sceneSizeWillChange(to size: CGSize) {
    camera.aspect = Float(size.width / size.height)
    sceneSize = size
  }
}
