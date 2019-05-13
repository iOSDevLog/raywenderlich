// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

struct PointValue: CustomStringConvertible {
  var x, y: Int
  
  var description: String {
    return "(\(x), \(y))"
  }
  
  mutating func transpose() {
    (y, x) = (x, y)
  }
}

final class PointReference: CustomStringConvertible {
  var x, y: Int
  
  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
  
  var description: String {
    return "(\(x), \(y))"
  }
  
  func transpose() {
    (y, x) = (x, y)
  }
}

/////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////

