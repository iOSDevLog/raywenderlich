//
//  SpacetimeColors.swift
//  SpacetimeUI
//
//  Created by Ellen Shapiro on 3/25/18.
//  Copyright © 2018 RayWenderlich.com. All rights reserved.
//

import UIKit

public enum SpacetimeColor {
  case
  navigationBarBackground,
  navigationBarContent,
  tabBarContent,
  success,
  failure,
  defaultText,
  buttonBackground,
  buttonText
  
  public var color: UIColor {
    switch self {
    case .navigationBarBackground,
         .tabBarContent:
      return UIColor.spc_from(r: 9, g: 51, b: 119)
    case .defaultText:
      return .darkText
    default:
      return .orange
    }
  }
}
