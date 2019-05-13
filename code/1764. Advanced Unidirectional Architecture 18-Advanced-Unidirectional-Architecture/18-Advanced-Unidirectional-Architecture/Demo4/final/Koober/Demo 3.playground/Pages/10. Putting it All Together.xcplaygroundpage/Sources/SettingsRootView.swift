/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import UIKit

public class SettingsRootView: UIView {
  private let tableView: SettingsTableView
  private let navBar = UINavigationBar()
  private unowned let ixResponder: SettingsIXResponder

  public init(frame: CGRect = .zero,
              ixResponder: SettingsIXResponder) {
    self.ixResponder = ixResponder
    self.tableView = SettingsTableView(ixResponder: ixResponder)
    super.init(frame: frame)

    build()
    configureNav()
  }

  private func build() {
    addSubview(tableView)
    addSubview(navBar)
  }

  private func configureNav() {
    navBar.prefersLargeTitles = true
    let item = UINavigationItem(title: "Settings")
    navBar.setItems([item], animated: false)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    layoutNavBar()
    layoutTableView()
  }

  private func layoutNavBar() {
    navBar.sizeToFit()
  }

  private func layoutTableView() {
    tableView.frame = bounds
    tableView.contentInset = UIEdgeInsets(top: navBar.frame.size.height,
                                          left: 0, bottom: 0, right: 0)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported by this class.")
  }

  public func update(with viewModel: SettingsViewState) {
    tableView.viewModel = viewModel
  }
}
