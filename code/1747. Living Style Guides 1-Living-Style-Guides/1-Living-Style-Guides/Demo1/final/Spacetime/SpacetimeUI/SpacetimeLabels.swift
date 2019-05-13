//
//  SpacetimeLabels.swift
//  SpacetimeUI
//
//  Created by Ellen Shapiro on 3/25/18.
//  Copyright © 2018 RayWenderlich.com. All rights reserved.
//

import UIKit

enum SpacetimeLabelStyle {
  case
  cellTitle

  var textColor: SpacetimeColor {
    return .defaultText
  }
  
  private var fontType: SpacetimeFont {
    return .bold
  }
  
  private var fontSize: SpacetimeFontSize {
    return .normal
  }
  
  var font: UIFont {
    return self.fontType.of(size: self.fontSize)
  }
}

public class SpacetimeBaseLabel: UILabel {
  
  var labelStyle: SpacetimeLabelStyle! {
    didSet {
      self.font = labelStyle.font
      self.textColor = labelStyle.textColor.color
    }
  }
}

public class CellTitleLabel: SpacetimeBaseLabel {
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.labelStyle = .cellTitle
  }
}
