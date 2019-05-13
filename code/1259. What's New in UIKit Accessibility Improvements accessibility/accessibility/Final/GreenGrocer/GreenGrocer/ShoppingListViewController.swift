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

class ShoppingListViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  @IBOutlet weak var addButton: UIBarButtonItem!
  @IBOutlet weak var sortButton: UIBarButtonItem!
  
  var shoppingList = [ListItem(name: "Avocado"),
                      ListItem(name: "Strawberries"),
                      ListItem(name: "Sweet Potatoes"),
                      ListItem(name: "Oranges"),
                      ListItem(name: "Cantaloupe")]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dropDelegate = self
    tableView.dragDelegate = self
    tableView.dragInteractionEnabled = true
    configureAccessibility()
  }
  
  func configureAccessibility() {
    addButton.accessibilityLabel = "Add"
    addButton.accessibilityHint = "Display a prompt for adding new list items"
    
    sortButton.accessibilityLabel = "Sort"
    sortButton.accessibilityHint = "Sort the shopping list alphabetically"
  }

  @IBAction func sortPressed(_ sender: Any) {
    let originalList = shoppingList
    var movedStrings: Set<String> = []
    shoppingList = Array(Set(shoppingList)).sorted {
      $0.name.caseInsensitiveCompare($1.name) == .orderedAscending
    }
    
    tableView.performBatchUpdates({
      for (index, item) in originalList.enumerated() {
        let oldIndexPath = IndexPath(row: index, section: 0)
        if movedStrings.contains(item.name) {
          tableView.deleteRows(at: [oldIndexPath],
                               with: UITableViewRowAnimation.automatic)
        } else if let newIndexRow = shoppingList.index(of: item) {
          movedStrings.insert(item.name)
          let newIndexPath = IndexPath(row: newIndexRow, section: 0)
          tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        }
      }
    }, completion: nil)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItemSegue" {
      guard let navController = segue.destination as? UINavigationController
        else { return }
      if let destination = navController.topViewController as? AddItemViewController {
        destination.delegate = self
      }
    }
  }
}

// MARK: - UITableViewDataSource
extension ShoppingListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shoppingList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCell", for: indexPath)
    
    let currentItem = shoppingList[indexPath.row]
    if let cell = cell as? ShoppingListCell {
      cell.configureCell(with: currentItem)
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ShoppingListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = shoppingList[indexPath.row]
    let checked = item.checked
    item.checked = !checked
    tableView.reloadRows(at: [indexPath], with: .automatic)

    let selectedRow = tableView.cellForRow(at: indexPath)
    selectedRow?.setSelected(false, animated: true)
  }
}

protocol ListControllerProtocol: class, NSObjectProtocol {
  func addItem(named name: String)
}

extension ShoppingListViewController: ListControllerProtocol {
  func addItem(named name: String) {
    let newItem = ListItem(name: name)
    shoppingList.append(newItem)
    tableView?.reloadData()
  }
}

extension ShoppingListViewController: UITableViewDragDelegate {
  public func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    let listItem = shoppingList[indexPath.row]
    let provider = NSItemProvider(object: listItem)
    let dragItem = UIDragItem(itemProvider: provider)
    return [dragItem]
  }
}

extension ShoppingListViewController: UITableViewDropDelegate {
  func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
    
    DispatchQueue.main.async {
     tableView.performBatchUpdates({
      coordinator.items.forEach {
        [weak self] (item) in
          guard let sourceIndexPath = item.sourceIndexPath, let `self` = self else { return }
          let row = self.shoppingList.remove(at: sourceIndexPath.row)
          self.shoppingList.insert(row, at: destinationIndexPath.row)
          tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
      }
     }, completion: nil)
    }
  }
  
  func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
    return session.canLoadObjects(ofClass: ListItem.self)
  }
  
  func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
    return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
  }
}
