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

