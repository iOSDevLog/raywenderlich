//
//  SpacetimeColors.swift
//  SpacetimeUI
//
//  Created by Ellen Shapiro on 3/25/18.
//  Copyright © 2018 RayWenderlich.com. All rights reserved.
//

import UIKit

public enum SpacetimeColor: String {
  case
  navigationBarBackground,
  navigationBarContent,
  tabBarContent,
  success,
  failure,
  defaultText,
  buttonBackground,
  buttonBorder,
  buttonText
  
  public var color: UIColor {
    switch self {
    case .navigationBarBackground,
         .tabBarContent,
         .buttonBorder:
      return UIColor.spc_from(r: 9, g: 51, b: 119)
    case .navigationBarContent,
         .buttonText:
      return .white
    case .success:
      return UIColor.spc_from(r: 3, g: 91, b: 18)
    case .failure:
      return UIColor.spc_from(r: 135, g: 20, b: 12)
    case .defaultText:
      return .darkText
    case .buttonBackground:
      return .black
    }
  }
}

extension SpacetimeColor: StyleGuideViewable {
  
  public var view: UIView {
    let view = UIView()
    view.backgroundColor = self.color
    return view
  }
}
