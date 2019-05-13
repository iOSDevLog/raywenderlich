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

import UIKit
import KooberKit

class ProfileContentRootView: NiblessView {
  weak var ixResponder: ProfileIXResponder?
  var userProfile: UserProfile?

  let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier.cell.rawValue)
    return tableView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    [tableView].forEach(addSubview)

    tableView.dataSource = self
    tableView.delegate = self
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    tableView.frame = bounds
  }

  func update(state: UserProfile) {
    userProfile = state
    tableView.reloadData()
  }
}

extension ProfileContentRootView: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return userProfile.exists ? 3 : 0
    case 1:
      return 1
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cell.rawValue)
    cell?.textLabel?.text = content(forIndexPath: indexPath)
    styleCell(forIndexPath: indexPath, cell: cell)
    return cell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.section == 1 && indexPath.row == 0 {
      ixResponder?.signOut()
    }
  }

  /*
  func label(forIndexPath indexPath: IndexPath) -> String {
    switch indexPath.row {
    case 0:
      return "Name"
    case 1:
      return "Email"
    case 2:
      return "Mobile Number"
    default:  
      fatalError()
    }
  }*/

  func styleCell(forIndexPath indexPath: IndexPath, cell: UITableViewCell?) {
    if indexPath.section == 1 {
      cell?.textLabel?.textAlignment = .center
      cell?.textLabel?.textColor = UIColor(0xF2333B)
    }
  }
  
  func content(forIndexPath indexPath: IndexPath) -> String {
    switch indexPath.section {
    case 0:
      switch indexPath.row {
      case 0:
        return userProfile!.name
      case 1:
        return userProfile!.email
      case 2:
        return userProfile!.mobileNumber
      default:
        fatalError()
      }
    case 1:
      return "Sign Out"
    default:
      fatalError()
    }
  }
}
