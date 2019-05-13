// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

/// Distribution example

class Distribution {
  
  func sample() -> Double {
    fatalError("Must override")
  }
  
  func sample(count: Int) -> [Double] {
    return (1...count).map { _ in sample() }
  }
}

class UniformDistribution: Distribution {
  
  var range: ClosedRange<Int>

  init(range: ClosedRange<Int>) {
    self.range = range
  }
  
  override func sample() -> Double {
    return Double(Int.random(in: range))
  }
}

let d20 = UniformDistribution(range: 1...20)

d20.sample(count: 10)

// Shape Geometry

class GeometryBase {
  func area() -> Double {
    fatalError("derived class must implement")
  }
}

// if you want to be able to override

extension GeometryBase {
  @objc func perimeter() -> Double {
    fatalError("derived class must implement")
  }
}

class DrawableBase: NSObject {
  // Draw is not exposed to Objective-C like it was in Swift 3
  func draw() {
    fatalError("derived class")
  }
}
