//
//  ScaryBugsTableViewController.swift
//  ScaryBugs
//
//  Created by Brian on 10/26/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ScaryBugsTableViewController: UITableViewController {
  
  var bugs = [ScaryBug]()
  
  override func viewDidLoad() { super.viewDidLoad()
    bugs = ScaryBug.bugs()
  }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bugs.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("BugCell", forIndexPath: indexPath)
    let bug = bugs[indexPath.row]
    cell.textLabel?.text = bug.name
    cell.detailTextLabel?.text = ScaryBug.scaryFactorToString(bug.howScary)
    if let imageView = cell.imageView, bugImage = bug.image {
      imageView.image = bugImage
    }

    return cell
  }
}