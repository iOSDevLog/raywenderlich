//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by Brian on 6/19/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
  func addItemViewControllerDidCancel(_ controller: AddItemTableViewController)
  func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem)
  func addItemViewController(_ controller: AddItemTableViewController, didFinishEditing item: ChecklistItem)
}

class AddItemTableViewController: UITableViewController {

  weak var delegate: AddItemViewControllerDelegate?
  weak var todoList: TodoList?
  weak var itemToEdit: ChecklistItem?
  
  @IBOutlet weak var cancelBarButton: UIBarButtonItem!
  @IBOutlet weak var addBarButton: UIBarButtonItem!
  @IBOutlet weak var textfield: UITextField!
 
  
  @IBAction func cancel(_ sender: Any) {
    delegate?.addItemViewControllerDidCancel(self)
  }
  
  @IBAction func done(_ sender: Any) {
    if let item = itemToEdit, let text = textfield.text {
      item.text = text
      delegate?.addItemViewController(self, didFinishEditing: item)
    } else {
      if let item = todoList?.newTodo() {
        if let textFieldText = textfield.text {
          item.text = textFieldText
        }
        item.checked = false
        delegate?.addItemViewController(self, didFinishAdding: item)
      }
    }
    

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let item = itemToEdit {
      title = "Edit Item"
      textfield.text = item.text
      addBarButton.isEnabled = true
    }
    navigationItem.largeTitleDisplayMode = .never
  }
  
  override func viewWillAppear(_ animated: Bool) {
    textfield.becomeFirstResponder()
  }
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
}

extension AddItemTableViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textfield.resignFirstResponder()
    return false
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    guard let oldText = textfield.text,
          let stringRange = Range(range, in: oldText) else {
        return false
    }
    
    let newText = oldText.replacingCharacters(in: stringRange, with: string)
    if newText.isEmpty {
      addBarButton.isEnabled = false
    } else {
      addBarButton.isEnabled = true
    }
    return true
  }
  
  
}
