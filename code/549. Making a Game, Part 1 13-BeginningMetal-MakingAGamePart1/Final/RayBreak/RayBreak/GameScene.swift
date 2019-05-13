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

class GameScene: Scene {
  
  enum Constants {
    static let gameHeight: Float = 48
    static let gameWidth: Float = 27
    static let bricksPerRow = 8
    static let bricksPerColumn = 8
  }
  
  let ball: Model
  let paddle: Model
  
  let bricks: Instance

  override init(device: MTLDevice, size: CGSize) {
    ball =  Model(device: device, modelName: "ball")
    paddle = Model(device: device, modelName: "paddle")
    
    bricks = Instance(device: device, modelName: "brick",
                      instances: Constants.bricksPerRow * Constants.bricksPerColumn)
    
    super.init(device: device, size: size)

    camera.position.z = -sceneOffset(height: Constants.gameHeight,
                                     fov: camera.fovRadians)
    camera.position.x = -Constants.gameWidth / 2
    camera.position.y = -Constants.gameHeight / 2
    camera.rotation.x = radians(fromDegrees: 20)
    camera.position.y = -Constants.gameHeight / 2 + 5
    
    light.color = float3(1, 1, 1)
    light.ambientIntensity = 0.3
    light.diffuseIntensity = 0.8
    light.direction = float3(0, -1, -1)
    setupScene()
  }
  
  func setupScene() {
    ball.position.x = Constants.gameWidth / 2
    ball.position.y = Constants.gameHeight * 0.1
    ball.materialColor = float4(0.5, 0.9, 0, 1)
    add(childNode: ball)
    
    paddle.position.x = Constants.gameWidth / 2
    paddle.position.y = Constants.gameHeight * 0.05
    paddle.materialColor = float4(1, 0, 0, 1)
    add(childNode: paddle)
    
    let border = Model(device: device, modelName: "border")
    border.position.x = Constants.gameWidth/2
    border.position.y = Constants.gameHeight/2
    border.materialColor = float4(0.51, 0.24, 0, 1)
    add(childNode: border)
    
    let colors = generateColors(number: Constants.bricksPerRow)
    
    let margin = Constants.gameWidth * 0.11
    let startY = Constants.gameHeight * 0.5
    
    for row in 0..<Constants.bricksPerRow {
      for column in 0..<Constants.bricksPerColumn {
        var position = float3(0)
        position.x = margin + (margin * Float(row))
        position.y = startY + (margin * Float(column))
        let index = row * Constants.bricksPerColumn + column
        bricks.nodes[index].position = position
        bricks.nodes[index].materialColor = colors[row]
      }
    }
    add(childNode: bricks)
  }
  
  override func update(deltaTime: Float) {
    for brick in bricks.nodes {
      brick.rotation.y += π / 4 * deltaTime
      brick.rotation.z += π / 4 * deltaTime
    }
  }
  
  func sceneOffset(height: Float, fov: Float) -> Float {
    return (height / 2) / tan(fov / 2)
  }
}


