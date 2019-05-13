// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import CoreGraphics

struct Circle {
  var origin: CGPoint
  var radius: CGFloat
}

protocol Geometry {
  func area() -> CGFloat
}

extension Circle: Geometry {
  func area() -> CGFloat {
    return .pi * radius * radius
  }
}

extension CGRect: Geometry {
  func area() -> CGFloat {
    return size.width * size.height
  }
}

let circle = Circle(origin: .zero, radius: 10)
let rect = CGRect(origin: .zero, size: CGSize(width: 300, height: 200))
let shapes: [Geometry] = [circle, rect]


// Compute the total perimeter (not area) of the shapes array
// You may add to the Geometry formal protocol

print(shapes.reduce(0) { $0 + $1.area() })


