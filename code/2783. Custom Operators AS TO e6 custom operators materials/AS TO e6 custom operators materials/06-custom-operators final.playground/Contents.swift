// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation
import CoreGraphics

public struct CGAngle {
  public var radians: CGFloat
  
  public init(radians: CGFloat) {
    self.radians = radians
  }
}

extension CGAngle {
  
  public init(degrees: CGFloat) {
    radians = degrees / 180.0 * CGFloat.pi
  }
  
  @inlinable public var degrees: CGFloat {
    get {
      return radians / CGFloat.pi * 180.0
    }
    set {
      radians = newValue / 180.0 * CGFloat.pi
    }
  }
}

extension CGAngle: Comparable {
  
  public mutating func normalize() {
    radians = normalized().radians
  }
  
  public func normalized() -> CGAngle {
    return CGAngle(radians: atan2(sin(radians), cos(radians)))
  }
  
  // Equality is based on normalizing the angles, comarison made to within a millionth of a degree
  
  public static func ==(lhs: CGAngle, rhs: CGAngle) -> Bool {
    return abs(lhs.normalized().radians - rhs.normalized().radians) < 1e-6
  }
  
  public static func <(lhs: CGAngle, rhs: CGAngle) -> Bool {
    return lhs.normalized().radians < rhs.normalized().radians
  }
}

CGAngle(radians: 0) == CGAngle(degrees: 360)

@inlinable public func cos(_ angle: CGAngle) -> CGFloat {
  return CGFloat(cos(angle.radians))
}

@inlinable public func sin(_ angle: CGAngle) -> CGFloat {
  return CGFloat(sin(angle.radians))
}

public extension CGAngle {
  @inlinable static func +(lhs: CGAngle, rhs: CGAngle) -> CGAngle {
    return CGAngle(radians: lhs.radians + rhs.radians)
  }
  
  @inlinable static func +=(lhs: inout CGAngle, rhs: CGAngle) {
    lhs = lhs + rhs
  }
  
  @inlinable static prefix func -(angle: CGAngle) -> CGAngle {
    return CGAngle(radians: -angle.radians)
  }
  
  @inlinable static func -(lhs: CGAngle, rhs: CGAngle) -> CGAngle {
    return lhs + (-rhs)
  }
  
  @inlinable static func -=(lhs: inout CGAngle, rhs: CGAngle) {
    lhs = lhs - rhs
  }
}

CGAngle(radians: 2 * .pi) + CGAngle(degrees: 100) + CGAngle(degrees: 80) == CGAngle(radians: .pi)

