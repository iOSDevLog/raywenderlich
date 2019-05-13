//
//  UIFont+Spacetime.swift
//  Spacetime
//
//  Created by Ellen Shapiro on 1/7/18.
//  Copyright © 2018 RayWenderlich.com. All rights reserved.
//

import UIKit

/**
 Good resource for fonts and their font names available on iOS:
 http://iosfonts.com/
 */
public extension UIFont {
  
  public static func spc_standard(size: CGFloat) -> UIFont {
    return UIFont(name: "Futura-Medium", size: size)!
  }
  
  public static func spc_consensed(size: CGFloat) -> UIFont {
    return UIFont(name: "Futura-CondensedMedium", size: size)!
  }
  
  public static func spc_condensedBold(size: CGFloat) -> UIFont {
    return UIFont(name: "Futura-CondensedExtraBold", size: size)!
  }
}

public enum SpacetimeFont {
  case
  standard,
  condensed,
  bold,
  condensedBold
  
  public func of(size: SpacetimeFontSize) -> UIFont {
    switch self {
    case .bold:
      return UIFont(name: "Futura-Bold", size: size.value)!
    default:
      return UIFont(name: "Chalkduster", size: size.value)!
    }
  }
}

public enum SpacetimeFontSize {
  case
  tiny,
  medium,
  normal
  
  var value: CGFloat {
    switch self {
    case .tiny:
      return 10
    case .medium:
      return 16
    case .normal:
      return 17
    }
  }
}
