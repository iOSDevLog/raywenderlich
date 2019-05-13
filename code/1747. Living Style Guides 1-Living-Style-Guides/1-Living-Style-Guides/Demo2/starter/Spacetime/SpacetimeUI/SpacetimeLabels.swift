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
  calloutText,
  cellTitle,
  cellSubtitle,
  detailText,
  explanationText
  
  var textColor: SpacetimeColor {
    switch self {
    case .calloutText,
         .cellSubtitle,
         .cellTitle,
         .detailText,
         .explanationText:
      return .defaultText
    }
  }
  
  private var fontType: SpacetimeFont {
    switch self {
    case .calloutText,
         .cellSubtitle,
         .detailText:
      return .condensed
    case .cellTitle:
      return .bold
    case .explanationText:
      return .standard
    }
  }
  
  private var fontSize: SpacetimeFontSize {
    switch self {
    case .calloutText,
         .cellSubtitle,
         .cellTitle:
      return .normal
    case .detailText:
      return .small
    case .explanationText:
      return .medium
    }
  }
  
  var font: UIFont {
    return self.fontType.of(size: self.fontSize)
  }
}

@IBDesignable
public class SpacetimeBaseLabel: UILabel {
  
  var labelStyle: SpacetimeLabelStyle! {
    didSet {
      self.font = labelStyle.font
      self.textColor = labelStyle.textColor.color
    }
  }
  
  func commonSetup() {
    // Code here will be executed in all setup states
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    self.commonSetup()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.commonSetup()
  }
  
  override public func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    self.commonSetup()
  }
}

public class CellTitleLabel: SpacetimeBaseLabel {
  
  override func commonSetup() {
    self.labelStyle = .cellTitle
  }
}

public class ExplanationLabel: SpacetimeBaseLabel {
  
  override func commonSetup() {
    self.labelStyle = .explanationText
  }
}

public class CellSubtitleLabel: SpacetimeBaseLabel {
  
  override func commonSetup() {
    self.labelStyle = .cellSubtitle
  }
}

public class DetailLabel: SpacetimeBaseLabel {
  
  override func commonSetup() {
    self.labelStyle = .detailText
  }
}

public class CalloutLabel: SpacetimeBaseLabel {
  
  override func commonSetup() {
    self.labelStyle = .calloutText
  }
}
