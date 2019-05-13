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
public enum SpacetimeFont {
  case
  standard,
  condensed,
  bold,
  condensedBold
  
  public func of(size: SpacetimeFontSize) -> UIFont {
    switch self {
    case .standard:
      return UIFont(name: "Futura-Medium", size: size.value)!
    case .condensed:
      return UIFont(name: "Futura-CondensedMedium", size: size.value)!
    case .bold:
      return UIFont(name: "Futura-Bold", size: size.value)!
    case .condensedBold:
      return UIFont(name: "Futura-CondensedExtraBold", size: size.value)!
    }
  }
}

public enum SpacetimeFontSize {
  case
  tiny,
  small,
  medium,
  normal
  
  var value: CGFloat {
    switch self {
    case .tiny:
      return 10
    case .small:
      return 14 
    case .medium:
      return 16
    case .normal:
      return 17
    }
  }
}
