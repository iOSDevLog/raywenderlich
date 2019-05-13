// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation
import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGPoint
import struct CoreGraphics.CGSize
import struct CoreGraphics.CGRect

struct CGAngle {
  var radians: CGFloat
}

extension CGAngle {
  
  @inlinable init(degrees: CGFloat) {
    radians = degrees / 180.0 * CGFloat.pi
  }
  
  @inlinable var degrees: CGFloat {
    get {
      return radians / CGFloat.pi * 180.0
    }
    set {
      radians = newValue / 180.0 * CGFloat.pi
    }
  }
}

extension CGAngle: CustomStringConvertible {
  var description: String {
    return String(format: "%0.2f°", degrees)
  }
}

let angle = CGAngle(radians: .pi)

enum Shape {
  case circle(center: CGPoint, radius: CGFloat)
  case square(origin: CGPoint, size: CGFloat)
  case rotatedSquare(origin: CGPoint, size: CGFloat, angle: CGAngle)
  case rect(CGRect)
  case rotatedRect(CGRect, CGAngle)
  case ellipse(CGRect)
  case rotatedEllipse(CGRect, CGAngle)
}

// Make a circle with a center at the origin and radius of 10

let circle = Shape.circle(center: .zero, radius: 10)


