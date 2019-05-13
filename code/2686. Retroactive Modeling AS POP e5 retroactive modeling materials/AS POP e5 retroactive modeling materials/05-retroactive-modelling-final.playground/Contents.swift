// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import CoreGraphics

struct Circle {
  var origin: CGPoint
  var radius: CGFloat
}

let circle = Circle(origin: .zero, radius: 10)
let rect = CGRect(origin: .zero, size: CGSize(width: 300, height: 200))

// Create an array of circles and rectangles
// Compute the sum of all the areas

protocol Geometry {
  var origin: CGPoint { get set }
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

let shapes: [Geometry] = [circle, rect]

print(shapes.reduce(0) { $0 + $1.area() })
