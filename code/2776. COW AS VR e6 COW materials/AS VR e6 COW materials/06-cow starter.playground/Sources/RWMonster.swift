// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

// Suppose you are given this Obective-C Monster to work with, and cannot
// convert it to Swift.
@objc public class RWMonster: NSObject, NSCopying {
  
  public init(name: String, hitPoints: Int) {
    self.name = name
    self.hitPoints = hitPoints
  }
  
  override public var description: String {
    return "\(name): \(hitPoints)"
  }
  
  public func copy(with zone: NSZone? = nil) -> Any {
    return RWMonster(name: name, hitPoints: hitPoints)
  }
  
  public var name: String
  public var hitPoints: Int
}
