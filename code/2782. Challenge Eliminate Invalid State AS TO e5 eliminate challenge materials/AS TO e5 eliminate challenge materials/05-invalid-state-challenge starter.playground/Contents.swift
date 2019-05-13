// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation
import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGPoint
import struct CoreGraphics.CGSize
import struct CoreGraphics.CGRect

// Refactor Shape so that it is self documenting and makes it impossible to
// represent invalid states.

struct Shape {
  
  enum `Type` {
    case circle
    case square
    case rotatedSquare
    case rect
    case rotatedRect
    case ellipse
    case rotatedEllipse
  }
  
  var shapeType: Type
  var rect: CGRect
  var angle: CGFloat
}

// Make a circle with a center at the origin and radius of 10

let center = CGPoint.zero
let radius: CGFloat = 10
let circle = Shape(shapeType: .circle,
                   rect: CGRect(x: center.x - radius,
                                y: center.y - radius,
                                width: radius*2,
                                height: radius*2),
                   angle: 0)

