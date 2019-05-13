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

class LandscapeScene: Scene {
  
  let sun: Model
  let ground: Plane
  let grass: Instance
  let mushroom: Model
  
  override init(device: MTLDevice, size: CGSize) {
    ground = Plane(device: device)
    grass = Instance(device: device, modelName: "grass",
                     instances: 10000)
    mushroom = Model(device: device, modelName: "mushroom")
    sun = Model(device: device, modelName: "sun")
    super.init(device: device, size: size)
    add(childNode: sun)
    sun.materialColor = float4(1, 1, 0, 1)
    setupScene()
  }
  
  func setupScene() {
    ground.materialColor = float4(0.4, 0.3, 0.1, 1) // brown
    add(childNode: ground)
    add(childNode: grass)
    add(childNode: mushroom)
    
    ground.scale = float3(20)
    ground.rotation.x = radians(fromDegrees: 90)
    
    camera.rotation.x = radians(fromDegrees: -10)
    camera.position.z = -20
    camera.position.y = -2
    
    let greens = [
      float4(0.34, 0.51, 0.01, 1),
      float4(0.5, 0.5, 0, 1),
      float4(0.29, 0.36, 0.14, 1)
    ]
    
    for row in 0..<100 {
      for column in 0..<100 {
        var position = float3(0)
        position.x = Float(row) / 4
        position.z = Float(column) / 4
        
        let blade = grass.nodes[row * 100 + column]
        blade.scale = float3(0.5)
        blade.position = position
        
        blade.materialColor = greens[Int(arc4random_uniform(3))]
        blade.rotation.y = radians(fromDegrees: Float(arc4random_uniform(360)))
      }
    }
    grass.position.x = -12
    grass.position.z = -12
    
    mushroom.position.x = -6
    mushroom.position.z = -8
    mushroom.scale = float3(2)
    
    sun.position.y = 7
    sun.position.x = 6
    sun.scale = float3(2)
    
    camera.fovDegrees = 25
  }
  
  override func update(deltaTime: Float) {
  }
}
