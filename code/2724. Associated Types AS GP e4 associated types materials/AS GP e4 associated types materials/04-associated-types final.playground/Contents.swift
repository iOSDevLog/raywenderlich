// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

protocol Distribution {
  
  associatedtype Value
  
  func sample() -> Value
  func sample(count: Int) -> [Value]
}

extension Distribution {
  
  func sample(count: Int) -> [Value] {
    return (1...count).map { _ in sample() }
  }
}

//////////////////////////////////////////////////////////////////////

struct UniformDistribution: Distribution {
  
  typealias Value = Int
  
  var range: ClosedRange<Int>
  
  init(range: ClosedRange<Int>) {
    self.range = range
  }
  
  func sample() -> Int {
    return Int.random(in: range)
  }
}

//////////////////////////////////////////////////////////////////////

struct NormalDistribution: Distribution {
  
  typealias Value = Double
  
  var mean, stdDev: Double

  private func generateRandomUniforms() -> (Double, Double) {
    let u1 = Double.random(in: Double.leastNormalMagnitude..<1.0)
    let u2 = Double.random(in: Double.leastNormalMagnitude..<1.0)
    return (u1, u2)
  }
  
  func sample() -> Double {
    let (u1, u2) = generateRandomUniforms()
    let z0 = (-2.0 * log(u1)).squareRoot() * cos(2 * .pi * u2)
    return z0 * stdDev + mean
  }
  
  func sample(count: Int) -> [Double] {
    precondition(count > 0, "count must be greater than zero")
    var result: [Double] = []
    result.reserveCapacity(count)
    
    for _ in 1...count/2 {
      let (u1, u2) = generateRandomUniforms()
      let z0 = (-2.0 * log(u1)).squareRoot() * cos(2 * .pi * u2)
      let z1 = (-2.0 * log(u1)).squareRoot() * sin(2 * .pi * u2)
      result.append(z0 * stdDev + mean)
      result.append(z1 * stdDev + mean)
    }
    if count % 2 == 1 {
      result.append(sample())
    }
    return result
  }
}

//////////////////////////////////////////////////////////////////////

let d20 = UniformDistribution(range: 1...20)
d20.sample(count: 100)

let iq = NormalDistribution(mean: 100, stdDev: 15)
iq.sample(count: 100)

