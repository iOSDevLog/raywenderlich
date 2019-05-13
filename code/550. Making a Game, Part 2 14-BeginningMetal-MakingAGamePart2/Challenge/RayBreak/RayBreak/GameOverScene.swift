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

class GameOverScene: Scene {
  
  var gameOverModel: Model!
  var registerTouch = false
  var time: Float = 0

  var win: Bool = false {
    didSet {
      if win {
        gameOverModel = Model(device: device, modelName: "youwin")
        gameOverModel.materialColor = float4(0, 1, 0, 1)
      } else {
        gameOverModel = Model(device: device, modelName: "youlose")
        gameOverModel.materialColor = float4(1, 0, 0, 1)
      }
      add(childNode: gameOverModel)
    }
  }
  
  override init(device: MTLDevice, size: CGSize) {
    super.init(device: device, size: size)
    light.color = float3(1, 1, 1)
    light.ambientIntensity = 0.3
    light.diffuseIntensity = 0.8
    light.direction = float3(0, -1, -1)
    camera.position.z = -30
  }

  override func update(deltaTime: Float) {
    time += deltaTime
    
    let amplitude: Float = 0.5
    let period: Float = 2
    let periodicAmount = sin(Float(time + 0.8) * period) * amplitude * deltaTime
    
    gameOverModel.rotation.x -= π * periodicAmount // π is Option+P
    gameOverModel.scale += float3(periodicAmount/4)
  }
  
  override func touchesBegan(_ view: UIView, touches: Set<UITouch>,
  with event: UIEvent?) {
    registerTouch = true
  }
  
  override func touchesEnded(_ view: UIView, touches: Set<UITouch>,
                             with event: UIEvent?) {
    if registerTouch {
      let scene = GameScene(device: device, size: size)
      sceneDelegate?.transition(to: scene)
    }
  }
}
