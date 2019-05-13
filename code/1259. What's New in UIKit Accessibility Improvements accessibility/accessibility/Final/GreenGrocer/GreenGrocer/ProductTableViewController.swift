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
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
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
import MobileCoreServices

class ProductTableViewController: UITableViewController, DataStoreOwner {
  
  let searchController = UISearchController(searchResultsController: nil)
  public var listController: ListControllerProtocol?
  var dataStore: DataStore? {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 120
  }
  
  // MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataStore?.products.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
    
    var product: Product? = nil
    product = dataStore?.products[(indexPath as NSIndexPath).row]

    if let cell = cell as? ProductTableViewCell {
      cell.product = product
    }
    
    return cell
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destVC = segue.destination as? ProductViewController {
      let selectedRow = (tableView.indexPathForSelectedRow as NSIndexPath?)?.row ?? 0
      destVC.product = dataStore?.products[selectedRow]
    }
  }
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

      guard let product = dataStore?.products[indexPath.row] else { return nil }
      let addAction = UIContextualAction(style: .normal, title: "Add") {
        [weak self] (action, view, completionHandler) in
          guard let `self` = self else {
            completionHandler(false)
            return
          }
          self.listController?.addItem(named: product.name)
          completionHandler(true)
      }
      addAction.backgroundColor = UIColor(named:ggGreen)
      let configuration = UISwipeActionsConfiguration(actions: [addAction])
      return configuration
    }
  
  
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    guard let product = dataStore?.products[indexPath.row] else { return nil }
    let copyAction = UIContextualAction(style: .normal, title: "Copy") {
      (action, view, completionHandler) in
        let data = NSKeyedArchiver.archivedData(withRootObject: product)
        UIPasteboard.general.setData(data, forPasteboardType: Product.productTypeId)
        completionHandler(true)
    }
    copyAction.backgroundColor = UIColor(named:ggDarkGreen)
    let configuration = UISwipeActionsConfiguration(actions: [copyAction])
    return configuration

  }
  
  
  
  }
