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

import UIKit

extension UIView {

  func constrainToSuperview(_ edges: [NSLayoutAttribute], insetBy inset: CGFloat = 0) {
    for edge in edges {
      constrainToSuperview(edge, withOffset: offset(for: edge, ofInset: inset))
    }
  }

  func constrainToSafeAreaTop(of viewController: UIViewController, insetBy inset: CGFloat = 0) {
    topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: inset).isActive = true
  }

  private func offset(for edge: NSLayoutAttribute, ofInset inset: CGFloat) -> CGFloat {
    switch edge {
    case .top, .topMargin, .leading, .leadingMargin:
      return inset
    case .bottom, .bottomMargin, .trailing, .trailingMargin:
      return -inset
    default:
      print("Warning, offset not handled for edge \(edge)")
      return inset
    }
  }

  func constrainToSafeAreaBottom(of viewController: UIViewController, insetBy inset: CGFloat = 0) {
    bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset).isActive = true
  }

  @discardableResult func constrainToSuperview(_ edge: NSLayoutAttribute, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
    let superview = prepareForConstraints()
    let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: .equal, toItem: superview, attribute: edge, multiplier: 1, constant: offset)
    constraint.isActive = true
    return constraint
  }

  @discardableResult func constrain(to view: UIView, _ edge: NSLayoutAttribute, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
    let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: .equal, toItem: view, attribute: edge, multiplier: 1, constant: offset)
    constraint.isActive = true
    return constraint
  }

  func constrain(to view: UIView, edges: [NSLayoutAttribute], withOffset offset: CGFloat = 0) {
    for edge in edges {
      constrain(to: view, edge, withOffset: offset)
    }
  }

  @discardableResult func constrain(height: CGFloat) -> NSLayoutConstraint {
    let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
    constraint.isActive = true
    return constraint
  }

  func hideConstraint() -> NSLayoutConstraint {
    return constrain(height: 0)
  }

  @discardableResult func constrain(_ edge: NSLayoutAttribute, to view: UIView, _ otherEdge: NSLayoutAttribute, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
    _ = prepareForConstraints()
    let constraint = NSLayoutConstraint(item: self, attribute: edge, relatedBy: .equal, toItem: view, attribute: otherEdge, multiplier: 1, constant: offset)
    constraint.isActive = true
    return constraint
  }

  func add(_ view: UIView, constrainedTo edges: [NSLayoutAttribute], withInset inset: CGFloat = 0) {
    addSubview(view)
    view.constrainToSuperview(edges, insetBy: inset)
  }

  private func prepareForConstraints() -> UIView {
    guard let superview = self.superview else {
      fatalError("view doesn't have a superview")
    }
    translatesAutoresizingMaskIntoConstraints = false
    return superview
  }

  func hugContent(_ axis: UILayoutConstraintAxis) {
    setContentHuggingPriority(.required, for: axis)
  }

  func surroundedByView(insetBy inset: CGFloat) -> UIView {
    return surrounded(by: UIView(), inset: inset)
  }

  //swiftlint:disable:next colon this is the formatting for constrained generics
  func surrounded<T:UIView>(by view: T, inset: CGFloat) -> T {
    view.addSubview(self)
    constrainToSuperview([.leading, .top, .trailing, .bottom], insetBy: inset)
    return view
  }

}
