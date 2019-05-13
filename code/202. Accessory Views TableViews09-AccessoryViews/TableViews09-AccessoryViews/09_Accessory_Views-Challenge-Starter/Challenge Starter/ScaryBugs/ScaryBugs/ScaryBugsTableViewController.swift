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
  
  override func setEditing(editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    if editing {
      tableView.beginUpdates()
      for (index,bugSection) in bugSections.enumerate() {
        let indexPath = NSIndexPath(forRow: bugSection.bugs.count, inSection: index)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      }
      tableView.endUpdates()
      tableView.setEditing(true, animated: true)
    } else {
      tableView.beginUpdates()
      for (index,bugSection) in bugSections.enumerate() {
        let indexPath = NSIndexPath(forRow: bugSection.bugs.count, inSection: index)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      }
      tableView.endUpdates()
      tableView.setEditing(false, animated: true)
    }
  }
  
  override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    let bugSection = bugSections[indexPath.section]
    if indexPath.row >= bugSection.bugs.count {
      return .Insert
    } else {
      return .Delete
    }
  }
  
  override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    
    // 1
    let sourceSection = bugSections[sourceIndexPath.section]
    let bugToMove = sourceSection.bugs[sourceIndexPath.row]
    let destinationSection = bugSections[destinationIndexPath.section]
    
    // 2
    if sourceSection == destinationSection {
      if destinationIndexPath.row != sourceIndexPath.row {
        swap(&destinationSection.bugs[destinationIndexPath.row], &sourceSection.bugs[sourceIndexPath.row])
      }
      
    }
      
      // 3
    else {
      bugToMove.howScary = destinationSection.howScary
      destinationSection.bugs.insert(bugToMove, atIndex: destinationIndexPath.row)
      sourceSection.bugs.removeAtIndex(sourceIndexPath.row)
      
      // 4
      let delayInSeconds:Double = 0.2
      let dispatchTime = Int64(delayInSeconds * Double(NSEC_PER_SEC))
      let popTime = dispatch_time(DISPATCH_TIME_NOW, dispatchTime)
      dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
        self.tableView.reloadRowsAtIndexPaths([destinationIndexPath], withRowAnimation: .None)
      }
    }
  }
  
  override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
    let bugSection = bugSections[proposedDestinationIndexPath.section]
    if proposedDestinationIndexPath.row >= bugSection.bugs.count {
      return NSIndexPath(forRow: bugSection.bugs.count-1, inSection: proposedDestinationIndexPath.section)
    }
    return proposedDestinationIndexPath
  }
  
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    let bugSection = bugSections[indexPath.section]
    if indexPath.row >= bugSection.bugs.count && editing {
      return false
    }
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBugs()
    navigationItem.rightBarButtonItem = editButtonItem()
    tableView.estimatedRowHeight = 60.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      let bugSection = bugSections[indexPath.section]
      bugSection.bugs.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    else if editingStyle == .Insert {
      let bugSection = bugSections[indexPath.section]
      let newBug = ScaryBug(withName: "New Bug", imageName: nil, howScary: bugSection.howScary)
      bugSection.bugs.append(newBug)
      tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
  }
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    let bugSection = bugSections[indexPath.section]
    if self.editing && indexPath.row < bugSection.bugs.count {
      return nil
    }
    return indexPath
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let bugSection = bugSections[indexPath.section]
    if indexPath.row >= bugSection.bugs.count && editing {
      self.tableView(tableView, commitEditingStyle: .Insert, forRowAtIndexPath: indexPath)
    }
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return bugSections.count
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let bugSection = bugSections[section]
    return ScaryBug.scaryFactorToString(bugSection.howScary)
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let adjustment = editing ? 1 : 0
    let bugSection = bugSections[section]
    return bugSection.bugs.count + adjustment
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell: UITableViewCell
    let bugSection = bugSections[indexPath.section]
    
    if indexPath.row >= bugSection.bugs.count && editing {
      cell = tableView.dequeueReusableCellWithIdentifier("NewRowCell", forIndexPath: indexPath)
      cell.textLabel?.text = "Add Bug"
      cell.detailTextLabel?.text = nil
      cell.imageView?.image = nil
    } else {
      let bug = bugSection.bugs[indexPath.row]
      cell = tableView.dequeueReusableCellWithIdentifier("BugCell", forIndexPath: indexPath)
      if let bugCell = cell as? ScaryBugTableViewCell {
        
        bugCell.bugNameLabel.text = bug.name
        if bug.howScary.rawValue > ScaryFactor.AverageScary.rawValue {
          bugCell.howScaryImageView.image = UIImage(named: "shockedface2_full")
        } else {
          bugCell.howScaryImageView.image = UIImage(named: "shockedface2_empty")
        }
        
        if let bugImage = bug.image {
          bugCell.bugImageView.image = bugImage
        } else {
          bugCell.bugImageView.image = nil
        }
      }
      
    }
    
    return cell
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "GoToEdit" {
      if let editController = segue.destinationViewController as? EditTableViewController {
        if let indexPath  = tableView.indexPathForSelectedRow {
          let bugSection = bugSections[indexPath.section]
          let bug = bugSection.bugs[indexPath.row]
          editController.bug = bug
        }
      }
    }
  }
  
}