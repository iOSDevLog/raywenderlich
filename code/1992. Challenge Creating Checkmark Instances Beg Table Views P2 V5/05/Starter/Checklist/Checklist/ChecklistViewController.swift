//
//  ViewController.swift
//  Checklist
//
//  Created by Brian on 6/18/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

  var row0Item: ChecklistItem
  
  required init?(coder aDecoder: NSCoder) {
    row0Item = ChecklistItem()
    row0Item.text = "Take a jog"
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    
    if let label = cell.viewWithTag(1000) as? UILabel {
      if indexPath.row == 0 {
        label.text = row0Item.text
      } else if indexPath.row % 4 == 0 {
        label.text = "Watch a movie"
      } else if indexPath.row % 3 == 0 {
        label.text = "Code an app"
      } else if indexPath.row % 2 == 0 {
        label.text = "Walk the dog"
      } else if indexPath.row % 1 == 0 {
        label.text = "Study design patterns"
      }
    }
    configureCheckmark(for: cell, at: indexPath)
    
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      configureCheckmark(for: cell, at: indexPath)
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
    
    if indexPath.row == 0 {
      if row0Item.checked {
        cell.accessoryType = .none
      } else {
        cell.accessoryType = .checkmark
      }
      row0Item.checked = !row0Item.checked
    } else {
      if cell.accessoryType == .none {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
    
  }

}

