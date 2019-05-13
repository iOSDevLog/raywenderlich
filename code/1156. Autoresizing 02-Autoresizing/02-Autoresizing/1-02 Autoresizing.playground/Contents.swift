import UIKit

extension OptionSet {
  init<CompatibleOptionSet: OptionSet>(_ compatibleOptionSet: CompatibleOptionSet)
  where CompatibleOptionSet.RawValue == RawValue {
    self.init(rawValue: compatibleOptionSet.rawValue)
  }
}

extension UIView {
  struct AutoresizingFlexibilities: OptionSet {
    let rawValue: UInt
  }
  
  var autoresizingFlexibilities: AutoresizingFlexibilities {
    get {
      return AutoresizingFlexibilities(autoresizingMask)
    }
    set {
      autoresizingMask = UIViewAutoresizing(newValue)
    }
  }
}

extension UIView.AutoresizingFlexibilities {
  static var leftMargin: UIView.AutoresizingFlexibilities {
    return UIView.AutoresizingFlexibilities(UIViewAutoresizing.flexibleLeftMargin)
  }
  
  static var width: UIView.AutoresizingFlexibilities {
    return UIView.AutoresizingFlexibilities(UIViewAutoresizing.flexibleWidth)
  }
  
  static var rightMargin: UIView.AutoresizingFlexibilities {
    return UIView.AutoresizingFlexibilities(UIViewAutoresizing.flexibleRightMargin)
  }
  
  static var topMargin: UIView.AutoresizingFlexibilities {
    return UIView.AutoresizingFlexibilities(UIViewAutoresizing.flexibleTopMargin)
  }
  
  static var height: UIView.AutoresizingFlexibilities {
    return UIView.AutoresizingFlexibilities(UIViewAutoresizing.flexibleHeight)
  }
  
  static var bottomMargin: UIView.AutoresizingFlexibilities {
    return UIView.AutoresizingFlexibilities(UIViewAutoresizing.flexibleBottomMargin)
  }
}

UIView.AutoresizingFlexibilities.leftMargin
UIView.AutoresizingFlexibilities.width
UIView.AutoresizingFlexibilities.rightMargin

UIView.AutoresizingFlexibilities.topMargin
UIView.AutoresizingFlexibilities.height
UIView.AutoresizingFlexibilities.bottomMargin
//: Slide 7
UIViewAutoresizing.flexibleLeftMargin.rawValue    // 0b000_001
UIViewAutoresizing.flexibleWidth.rawValue         // 0b000_010
UIViewAutoresizing.flexibleRightMargin.rawValue   // 0b000_100

UIViewAutoresizing.flexibleTopMargin.rawValue     // 0b001_000
UIViewAutoresizing.flexibleHeight.rawValue        // 0b010_000
UIViewAutoresizing.flexibleBottomMargin.rawValue  // 0b100_000
//: Slide 8
extension UIView {
  typealias AutoresizingOptions = UIViewAutoresizing
}

UIView.AutoresizingOptions.flexibleLeftMargin
UIView.AutoresizingOptions.flexibleWidth
UIView.AutoresizingOptions.flexibleRightMargin

UIView.AutoresizingOptions.flexibleTopMargin
UIView.AutoresizingOptions.flexibleHeight
UIView.AutoresizingOptions.flexibleBottomMargin

