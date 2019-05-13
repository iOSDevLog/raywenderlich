///// Copyright (c) 2017 Razeware LLC
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

class StaffListViewController: UIViewController {
  
  // MARK: Constants
  private enum Constants {
    static let CellIdentifier = "Cell"
  }
  
  // MARK: Properties
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    return refreshControl
  }()
  private var staffList: [Staff]?
  
  // MARK: IB Outlets
  @IBOutlet var tableView: UITableView!
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableViewSetup()
    loadData()
  }
  
  // MARK: Implementation
  
  private func loadData() {
    StaffAPI.shared.loadStaffList { (staffList, errorMessage) in
      // First handle errors...
      guard let staffList = staffList else {
        // We did not get a staff list, so show an error
        NSLog("load staff list error: \(errorMessage ?? "Unknown")")
        // End the refreshing (Switch to main for the UI update)
        DispatchQueue.main.async {
          self.refreshControl.endRefreshing()
          // Alert
          AlertHelper.showSimpleAlert(title: "Load Error", message: "Unable to load staff right now. Ensure you have Internet connectivity and try again.", viewController: self)
        }
        // Return
        return
      }
      
      // ASSERT: We have a staffList...
      
      // Save the staff results to our VC property
      self.staffList = staffList
      // Switch to main for the UI update
      DispatchQueue.main.async {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
      }
    }
  }
  
  @objc private func refreshData() {
    self.loadData()
  }
  
  private func tableViewSetup() {
    // Wire this class up as a delegate to the table view
    tableView.dataSource = self
    // Add Refresh Control to Table View
    tableView.refreshControl = refreshControl
  }
  
  // MARK: - Navigation
  
  // Prepare to go to our detail view
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Proceed only if we have both a staffList and a selected index row
    if let staffList = staffList, let row = tableView.indexPathForSelectedRow?.row {
      // Point to the right staff member
      let staff = staffList[row]
      // Get a reference to the destination VC (cast as our base if possible since our details views implement it)
      let detailView = segue.destination as? StaffDetailBaseViewController
      // Assign the right staff member
      detailView?.staffMember = staff
    }
  }
  
}

// MARK: UITableViewDataSource

extension StaffListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Staff List"
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let staffList = staffList else {
      return 0
    }
    return staffList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier, for: indexPath)
    if let staffList = staffList {
      let row = indexPath.row
      let staff = staffList[row]
      cell.textLabel!.text = staff.name
      cell.detailTextLabel!.text = staff.mobile
    }
    return cell
  }
  
}
