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

class ViewController: UIViewController {

  var iconSets = [IconSet]()
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    iconSets = IconSet.iconSets()
    navigationItem.rightBarButtonItem = editButtonItem()
    tableView.allowsSelectionDuringEditing = true
    automaticallyAdjustsScrollViewInsets = false
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    if identifier == "GoToDetail" && editing {
      return false
    }
    return true
  }
  
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
  
  override func setEditing(editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    if editing {
      tableView.beginUpdates()
      for (index, set) in iconSets.enumerate() {
        let indexPath = NSIndexPath(forRow: set.icons.count, inSection: index)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      }
      tableView.endUpdates()
      tableView.setEditing(true, animated: true)
    } else {
      
      tableView.beginUpdates()
      for (index, set) in iconSets.enumerate() {
        let indexPath = NSIndexPath(forRow: set.icons.count, inSection: index)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      }
      
      tableView.endUpdates()
      tableView.setEditing(false, animated: true)
    }
  }
  
  func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    
    let set = iconSets[indexPath.section]
    if indexPath.row >= set.icons.count {
      return .Insert
    } else {
      return .Delete
    }
    
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return iconSets.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let adjustment = editing ? 1 : 0;
    return iconSets[section].icons.count + adjustment
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return iconSets[section].name
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("IconCell", forIndexPath: indexPath)
    let set = iconSets[indexPath.section]
    
    if indexPath.row >= set.icons.count && editing {
      cell.textLabel?.text = "Add Icon"
      cell.detailTextLabel?.text = nil
      cell.imageView?.image = nil
    } else {
      let icon = set.icons[indexPath.row]
      cell.textLabel?.text = icon.title
      cell.detailTextLabel?.text = icon.subtitle
      
      guard let imageView = cell.imageView else {
        return cell
      }

      if let iconImage = icon.image {
        imageView.image = iconImage
      } else {
        imageView.image = nil
      }
    }
      
    return cell
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

    let set = iconSets[indexPath.section]
    if editingStyle == .Delete {

      set.icons.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:.Automatic)
    } else if editingStyle == .Insert {
      let newIcon = Icon(withTitle: "New Icon", subtitle: "", imageName: nil)
      set.icons.append(newIcon)
      tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
  }
  
  func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    let set = iconSets[indexPath.section]
    if editing && indexPath.row < set.icons.count {
      return nil
    }
    return indexPath
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let set = iconSets[indexPath.section]
    if indexPath.row >= set.icons.count && editing {
      self.tableView(tableView, commitEditingStyle: .Insert, forRowAtIndexPath: indexPath)
    }
  }
  
}