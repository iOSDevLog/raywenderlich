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
import os.log

class TaskDetailsViewController: UIViewController {
  
  @IBOutlet var descriptionTextField: UITextField!
  @IBOutlet var notesTextField: UITextField!
  @IBOutlet var saveButton: UIBarButtonItem!
  
  @IBOutlet weak var containerView: UIView!
  var task: Task?
  var updatedReminderSetting: Bool? = nil
  var updatedReminderDate: Date? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    descriptionTextField.delegate = self
    if let task = task {
      descriptionTextField.text = task.taskDescription
      notesTextField.text = task.notes      
    }
    
    updateSaveButtonState()
  }
  
  // MARK: - Navigation
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    let isPresentingInAddTaskMode = presentingViewController is UINavigationController
    if isPresentingInAddTaskMode {
      dismiss(animated: true, completion: nil)
    } else if let owningNavigationController = navigationController {
      owningNavigationController.popViewController(animated: true)
    } else {
      fatalError("The TaskDetailsViewController is not inside a navigation controller.")
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    if segue.identifier == "ReminderTable" {
      let reminderTableVC = segue.destination as? ReminderTableViewController
      reminderTableVC?.delegate = self
    }
    guard let button = sender as? UIBarButtonItem, button === saveButton else {
      os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
      return
    }
    
    let description = descriptionTextField.text ?? ""
    let notes = notesTextField.text ?? ""
    let oldReminderSetting = task?.isReminderSet
    let oldReminderDate = task?.reminderDate
    
    task = Task(taskDescription: description, notes: notes)
    
    if let isReminderSet = updatedReminderSetting {
      task?.isReminderSet = isReminderSet
      updatedReminderSetting = nil
    } else {
      task?.isReminderSet = oldReminderSetting ?? false
    }
    
    if let reminderDate = updatedReminderDate {
      task?.reminderDate = reminderDate
      updatedReminderDate = nil
    } else {
      task?.reminderDate = oldReminderDate
    }
  }
}

extension TaskDetailsViewController: UITextFieldDelegate {
  //MARK: UITextFieldDelegate
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    updateSaveButtonState()
    navigationItem.title = textField.text
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    saveButton.isEnabled = false
  }
  
  //MARK: Private methods  
  func updateSaveButtonState() {    
    let description = self.descriptionTextField.text ?? ""
    saveButton.isEnabled = !description.isEmpty
  }
}

extension TaskDetailsViewController: ReminderViewDelegate {
  func reminderDataChanged(reminderSet: Bool, reminderDate: Date?) {
    updatedReminderSetting = reminderSet
    updatedReminderDate = reminderDate
  }
}
