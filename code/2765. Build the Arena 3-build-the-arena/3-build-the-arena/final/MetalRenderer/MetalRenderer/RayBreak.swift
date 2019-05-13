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

class RayBreak: Scene {
  enum Constants {
    static let columns = 4
    static let rows = 6
    static let paddleSpeed: Float = 0.2
    static let ballSpeed: Float = 10
  }
  
  let paddle = Model(name: "paddle")
  let ball = Model(name: "ball")
  let border = Model(name: "border")
  let bricks = Instance(name: "brick",
                        instanceCount: Constants.rows * Constants.columns)
  var gameArea: (width: Float, height: Float) = (0, 0)
  
  func setupBricks() {
    let margin = gameArea.width * 0.1
    let brickWidth = bricks.worldBoundingBox().width
    
    let halfGameWidth = gameArea.width / 2
    let halfGameHeight = gameArea.height / 2
    let halfBrickWidth = brickWidth / 2
    let cols = Float(Constants.columns)
    let rows = Float(Constants.rows)
    
    let hGap = (gameArea.width - brickWidth * cols - margin * 2) / (cols - 1)
    let vGap = (halfGameHeight - brickWidth * rows - margin + halfBrickWidth) / (rows - 1)
    for row in 0..<Constants.rows {
      for column in 0..<Constants.columns {
        let frow = Float(row)
        let fcol = Float(column)
        
        var position = float3(0)
        position.x = margin + hGap * fcol + brickWidth * fcol + halfBrickWidth
        position.x -= halfGameWidth
        position.z = vGap * frow + brickWidth * frow
        let transform = Transform(position: position, rotation: float3(0), scale: 1)
        bricks.transforms[row * Constants.columns + column] = transform
      }
    }
  }
  override func setupScene() {
    
    camera.rotation = [-0.78, 0, 0]
    camera.distance = 13.5
    camera.target.y = -2
    
    gameArea.width = border.worldBoundingBox().width - 1
    gameArea.height = border.worldBoundingBox().height - 1
    
    add(node: paddle)
    add(node: ball)
    add(node: border)
    add(node: bricks)
    
    paddle.position.z = -border.worldBoundingBox().height / 2.0 + 2
    ball.position.z = paddle.position.z + 1
    
    setupBricks()
  }
  
  override func updateScene(deltaTime: Float) {
  }
}
