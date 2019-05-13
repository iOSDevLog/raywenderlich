//
//  StyleGuideViewable.swift
//  SpacetimeUI
//
//  Created by Ellen Shapiro on 3/25/18.
//  Copyright © 2018 RayWenderlich.com. All rights reserved.
//

import Foundation

public protocol StyleGuideViewable {
  
  static var styleName: String { get }

  var itemName: String { get }
  
  var rawValue: String { get }
  
  var view: UIView { get }
}

extension StyleGuideViewable {
  public static var styleName: String {
    return "\(Self.self)".camelCaseToSpacing()
  }
  
  public var itemName: String {
    return self.rawValue.camelCaseToSpacing()
  }
}
