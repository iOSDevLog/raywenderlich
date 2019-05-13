//
//  ScaryBugsTableViewController.swift
//  ScaryBugs
//
//  Created by Brian on 10/26/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ScaryBugsTableViewController: UITableViewController {
  
  var bugSections = [BugSection]()
  
  private func setupBugs() {
    bugSections.append(BugSection(howScary: .NotScary))
    bugSections.append(BugSection(howScary: .ALittleScary))
    bugSections.append(BugSection(howScary: .AverageScary))
    bugSections.append(BugSection(howScary: .QuiteScary))
    bugSections.append(BugSection(howScary: .Aiiiiieeeee))
    
    let bugs = ScaryBug.bugs()
    for bug: ScaryBug in bugs {
      let bugSection = bugSections[bug.howScary.rawValue]
      bugSection.bugs.append(bug)
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBugs()
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return bugSections.count
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let bugSection = bugSections[section]
    return ScaryBug.scaryFactorToString(bugSection.howScary)
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let bugSection = bugSections[section]
    return bugSection.bugs.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("BugCell", forIndexPath: indexPath)

    let bugSection = bugSections[indexPath.section]
    let bug = bugSection.bugs[indexPath.row]
    
    cell.textLabel?.text = bug.name
    cell.detailTextLabel?.text = ScaryBug.scaryFactorToString(bug.howScary)
    if let imageView = cell.imageView, bugImage = bug.image {
      imageView.image = bugImage
    }

    return cell
  }
}