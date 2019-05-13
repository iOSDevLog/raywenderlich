/**
 * Copyright (c) 2018 Razeware LLC
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

class TaskTableViewController: UITableViewController {
  
  var tasks: [Task?] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadSampleTasks() 
  }
  
  private func loadSampleTasks() {
    let task1 = Task.init(description: "Task 1", notes: nil)
    let task2 = Task.init(description: "Task 2", notes: nil)
    
    tasks += [task1, task2]
  }
}

// MARK: - Table view data source
extension TaskTableViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "TaskTableViewCell"
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell else {
      fatalError("The dequeued cell is not an instance of TaskTableViewCell")
    }
    
    cell.taskLabel.text = tasks[indexPath.row]?.description
    return cell
  }
}

extension TaskTableViewController {
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    guard let segueID = segue.identifier else { return }
    switch segueID {
    case "AddTask":
      break
    case "ShowDetail":
      guard let taskDetailViewController = segue.destination as? TaskDetailsViewController else {
        fatalError("Unexpected Destination: \(segue.destination)")
      }
      
      guard let taskCell = sender as? TaskTableViewCell else {
        fatalError("Unexpected sender: \(sender.debugDescription)")
      }
      
      guard let indexPath = tableView.indexPath(for: taskCell) else {
        fatalError("The selected cell is not being displayed by the table")
      }
      
      taskDetailViewController.task = tasks[indexPath.row]
    default:
      fatalError("Unexpected Segue Identifier; \(segueID.debugDescription)")
    }
  }

  //MARK: Actions
  @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? TaskDetailsViewController, let task = sourceViewController.task {
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        // Update an existing task.
        tasks[selectedIndexPath.row] = task
        tableView.reloadRows(at: [selectedIndexPath], with: .none)
      } else {
        // Add a new task.
        let newIndexPath = IndexPath(row: tasks.count, section: 0)
        
        tasks.append(task)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
      }
    }
  }
}
