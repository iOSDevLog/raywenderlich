/*
 * Copyright (c) 2015 Razeware LLC
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

class ProductTableViewController: UITableViewController, DataStoreOwner {
  
  var dataStore : DataStore? {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 120
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataStore?.products.count ?? 0
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath)
    
    if let cell = cell as? ProductTableViewCell {
      cell.product = dataStore?.products[indexPath.row]
    }
    
    return cell
  }
  
    
  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destVC = segue.destinationViewController as? ProductViewController {
      let selectedRow = tableView.indexPathForSelectedRow?.row ?? 0
      destVC.product = dataStore?.products[selectedRow]
    }
  }
  
}


extension ProductTableViewController : RestorableActivity {
  override func restoreUserActivityState(activity: NSUserActivity) {
    switch activity.activityType {
    case productActivityName:
      if let id = activity.userInfo?["id"] as? String {
        displayVCForProductWithId(id)
      }
    default:
      break
    }
    
    super.restoreUserActivityState(activity)
  }
  
  var restorableActivities : Set<String> {
    return Set([productActivityName])
  }
  
  private func displayVCForProductWithId(id: String) {
    // 1:
    guard let id = NSUUID(UUIDString: id),
      let productIndex = dataStore?.products.indexOf({ $0.id.isEqual(id) }) else {
        return
    }
    tableView.selectRowAtIndexPath(NSIndexPath(forRow: productIndex, inSection: 0), animated: false, scrollPosition: .Middle)
    performSegueWithIdentifier("DisplayProduct", sender: self)
  }
}
