// Copyright (c) 2018 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

protocol Distribution {
    
  func sample() -> Int
  func sample(count: Int) -> [Int]
}

extension Distribution {
  
  func sample(count: Int) -> [Int] {
    return (1...count).map { _ in sample() }
  }
}

//////////////////////////////////////////////////////////////////////

struct UniformDistribution: Distribution {
    
  var range: ClosedRange<Int>
  
  init(range: ClosedRange<Int>) {
    self.range = range
  }
  
  func sample() -> Int {
    return Int.random(in: range)
  }
}

//////////////////////////////////////////////////////////////////////

let d20 = UniformDistribution(range: 1...10)
d20.sample(count: 100)


