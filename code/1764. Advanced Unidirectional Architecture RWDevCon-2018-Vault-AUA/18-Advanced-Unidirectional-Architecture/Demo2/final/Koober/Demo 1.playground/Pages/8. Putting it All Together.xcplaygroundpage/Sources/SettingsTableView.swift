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

class SettingsTableView: UITableView {
  var viewModel: SettingsViewState? {
    didSet { reloadState() }
  }

  override init(frame: CGRect = .zero,
                style: UITableViewStyle = .grouped) {
    super.init(frame: frame, style: style)
    configureTableView()
  }

  private func configureTableView() {
    self.dataSource = self
    self.delegate = self

    register(AccountTableViewCell.self,
             forCellReuseIdentifier: CellID.userProfile.id)
    register(UITableViewCell.self,
             forCellReuseIdentifier: CellID.theSwitch.id)
  }

  private func reloadState() {
    reloadData()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported by this class.")
  }
}

extension SettingsTableView: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    if let _ = viewModel {
      return 1
    } else {
      return 0
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
      return UserProfileSectionStrategy().rowHeight
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return UserProfileSectionStrategy().numberOfRows
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return UserProfileSectionStrategy().headerTitle
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      return UserProfileSectionStrategy().dequeueCell(from: tableView,
                                                      with: viewModel!)
    default:
      fatalError()
    }
  }
}

protocol SettingsTableViewStrategy {
  var rowHeight: CGFloat { get }
  var numberOfRows: Int { get }
  var headerTitle: String? { get }

  func dequeueCell(from tableView: UITableView,
                   with viewModel: SettingsViewState) -> UITableViewCell
}

class UserProfileSectionStrategy: SettingsTableViewStrategy {
  let rowHeight: CGFloat = 90
  let numberOfRows = 1
  let headerTitle: String? = "User Profile"

  func dequeueCell(from tableView: UITableView,
                   with viewModel: SettingsViewState) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellID.userProfile.id)! as! AccountTableViewCell
    cell.nameLabel.text = viewModel.userProfile.name
    cell.phoneNumberLabel.text = viewModel.userProfile.mobileNumber
    cell.emailLabel.text = viewModel.userProfile.email
    cell.selectionStyle = .none
    return cell
  }
}

private enum CellID: String {
  case userProfile
  case theSwitch

  var id: String {
    return rawValue
  }
}
