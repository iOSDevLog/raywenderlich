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

class CrowdScene: Scene {

  var humans = [Model]()
  
  override init(device: MTLDevice, size: CGSize) {
    super.init(device: device, size: size)
    for _ in 0..<40 {
      let human = Model(device: device, modelName: "humanFigure")
      humans.append(human)
      add(childNode: human)
      human.scale = float3(Float(arc4random_uniform(5))/10)
      human.position.x = Float(arc4random_uniform(5)) - 2
      human.position.y = Float(arc4random_uniform(5)) - 3
      human.materialColor = float4(Float(drand48()),
                    Float(drand48()),
                    Float(drand48()), 1)
    }
  }
  
  override func update(deltaTime: Float) {
  }
}
