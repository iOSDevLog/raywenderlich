/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import UIKit

enum BackgroundType: String {
  case light
  case dark
  
  var titleTextColor: UIColor {
    switch self {
    case .dark:
      return .lightTitleTextColor
    case .light:
      return .darkTitleTextColor
    }
  }
  
  var subtitleTextColor: UIColor {
    switch self {
    case .dark:
      return .lightSubtitleTextColor
    case .light:
      return .darkSubtitleTextColor
    }
  }
}

extension UIColor {
  static let backgroundColor = UIColor(red:0.99, green:0.99, blue:0.99, alpha:1.00)
  static let buttonBackgroundColor = UIColor(red:0.94, green:0.95, blue:0.96, alpha:1.00)
  static let borderColor: UIColor =  UIColor(red:0.35, green:0.35, blue:0.35, alpha:0.3)
  static let heroTextColor: UIColor = .white
  static let lightSubtitleTextColor: UIColor = UIColor.white.withAlphaComponent(0.8)
  static let lightTitleTextColor: UIColor = .white
  static let darkSubtitleTextColor: UIColor = .gray
  static let darkTitleTextColor: UIColor = .black
}

extension CGFloat {
  static let heroTextSize: CGFloat = 50.0
  static let headerTextSize: CGFloat = 28.0
  static let subHeaderTextSize: CGFloat = 15.0
  static let appHeaderTextSize: CGFloat = 15.0
  static let appSubHeaderTextSize: CGFloat = 13.0
  static let tinyTextSize: CGFloat = 8.0
}

extension UILabel {
  
  func configureHeaderLabel(withText text: String) {
    configure(withText: text, size: .headerTextSize, alignment: .left, lines: 0, weight: .bold)
  }
  
  func configureSubHeaderLabel(withText text: String) {
    configure(withText: text, size: .subHeaderTextSize, alignment: .left, lines: 0, weight: .semibold)
  }
  
  func configureHeroLabel(withText text: String) {
    configure(withText: text, size: .heroTextSize, alignment: .left, lines: 0, weight: .heavy)
  }
  
  func configureAppHeaderLabel(withText text: String){
    configure(withText: text, size: .appHeaderTextSize, alignment: .left, lines: 2, weight: .medium)
  }
  
  func configureAppSubHeaderLabel(withText text: String) {
    configure(withText: text, size: .appSubHeaderTextSize, alignment: .left, lines: 2, weight: .regular)
  }
  
  func configureTinyLabel(withText text: String) {
    configure(withText: text, size: .tinyTextSize, alignment: .center, lines: 1, weight: .regular)
  }
  
  private func configure(withText newText: String,
                         size: CGFloat,
                         alignment: NSTextAlignment,
                         lines: Int,
                         weight: UIFont.Weight) {
    text = newText
    font = UIFont.systemFont(ofSize: size, weight: weight)
    textAlignment = alignment
    numberOfLines = lines
    lineBreakMode = .byTruncatingTail
  }
}

extension UIImageView {
  func configureAppIconView(forImage appImage: UIImage, size: CGFloat) {
    image = appImage
    contentMode = .scaleAspectFit
    layer.cornerRadius = size/5.0
    layer.borderColor = UIColor.borderColor.cgColor
    layer.borderWidth = 0.5
    clipsToBounds = true
  }
}

extension UIButton {
  func roundedActionButton(withText text: String) {
    let bgColor: UIColor = text == AppAccess.onCloud.description ? .clear : .buttonBackgroundColor
    backgroundColor = bgColor
    setTitle(text, for: UIControl.State.normal)
    titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
    layer.cornerRadius = 15
    contentEdgeInsets = UIEdgeInsets(top: 5.5, left: 0, bottom:5.5, right: 0)
  }
}

extension UIStackView {
  func configure(withAxis axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, spacing: CGFloat, distribution: UIStackView.Distribution = .fill) {
    self.axis = axis
    self.alignment = alignment
    self.spacing = spacing
    self.distribution = distribution
  }
}

