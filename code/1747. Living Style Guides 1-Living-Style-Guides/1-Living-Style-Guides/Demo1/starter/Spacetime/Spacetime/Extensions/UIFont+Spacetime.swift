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
extension UIFont {
  
  public static func spc_standard(size: CGFloat) -> UIFont {
    return UIFont(name: "Futura-Medium", size: size)!
  }
  
  public static func spc_consensed(size: CGFloat) -> UIFont {
    return UIFont(name: "Futura-CondensedMedium", size: size)!
  }
  
  public static func spc_bold(size: CGFloat) -> UIFont {
    return UIFont(name: "Futura-Bold", size: size)!
  }
  
  public static func spc_condensedBold(size: CGFloat) -> UIFont {
    return UIFont(name: "Futura-CondensedExtraBold", size: size)!
  }
}
