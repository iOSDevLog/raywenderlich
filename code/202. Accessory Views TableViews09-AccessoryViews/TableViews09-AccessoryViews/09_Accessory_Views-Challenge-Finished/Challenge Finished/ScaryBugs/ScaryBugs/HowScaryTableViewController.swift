//
//  HowScaryTableViewController.swift
//  ScaryBugs
//
//  Created by Brian on 10/28/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class HowScaryTableViewController: UITableViewController {

  var bug: ScaryBug?
  
  func refresh() {
    for index in 0 ... ScaryFactor.TotalBugs.rawValue {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      let cell = tableView.cellForRowAtIndexPath(indexPath)
      cell?.accessoryType = bug?.howScary.rawValue == index ? .Checkmark : .None
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    refresh()
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if let scaryFactor = ScaryFactor(rawValue: indexPath.row) {
      bug?.howScary = scaryFactor
    }
    refresh()
    
  }

}
