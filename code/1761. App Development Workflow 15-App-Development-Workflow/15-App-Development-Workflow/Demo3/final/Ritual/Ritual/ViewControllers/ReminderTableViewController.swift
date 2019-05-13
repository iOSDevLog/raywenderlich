//
//  ReminderTableViewController.swift
//  Ritual
//
//  Created by Namrata Bandekar on 2018-03-14.
//  Copyright © 2018 Namrata Bandekar. All rights reserved.
//

import Foundation
import UIKit

class ReminderTableViewController: UITableViewController {
  @IBOutlet var reminderToggle: UISwitch!
  @IBOutlet var dateLabel: UILabel!
  private var reminderDate: Date?
  var delegate: ReminderViewDelegate?
  
  @IBAction func reminderSettingChanged(_ sender: UISwitch) {
    self.delegate?.reminderDataChanged(reminderSet: reminderToggle.isOn, reminderDate: self.reminderDate)
    self.tableView.reloadData()
  }
  
  @objc func dateChanged(_ sender: UIDatePicker) {
    self.reminderDate = sender.date
    self.dateLabel.text = DateFormatter.localizedString(from: sender.date, dateStyle: .medium, timeStyle: .short)
    self.delegate?.reminderDataChanged(reminderSet: reminderToggle.isOn, reminderDate: self.reminderDate)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 1 {
      self.showPicker()
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.reminderToggle.isOn {
      return 2
    }
    return 1
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 1 && self.reminderToggle.isOn == false {
      return 0
    }
    return 44
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.contentInset = UIEdgeInsetsMake(0, 20, 0, -20)
    self.tableView.separatorStyle = .none
    self.tableView.isScrollEnabled = false
    
    self.dateLabel.minimumScaleFactor = 0.1
    self.dateLabel.adjustsFontSizeToFitWidth = true
    
    let taskDetailsVC = self.delegate as? TaskDetailsViewController
    self.reminderToggle.isOn = taskDetailsVC?.task?.isReminderSet ?? false
    if let reminderDate = taskDetailsVC?.task?.reminderDate {
      self.dateLabel.text = DateFormatter.localizedString(from: reminderDate, dateStyle: .medium, timeStyle: .short)
    } else {
      self.dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
    }
  }
  
  private func showPicker() {
    let alertController = UIAlertController.init(title: "Select Date", message: "", preferredStyle: .actionSheet)
    alertController.addDatePicker(mode: .dateAndTime, date: Date.init()) { date in
      // action with selected date
      self.reminderDate = date
      self.dateLabel.text = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
      self.delegate?.reminderDataChanged(reminderSet: self.reminderToggle.isOn, reminderDate: self.reminderDate)
    }
    let okAction = UIAlertAction(title: "OK", style: .default, handler:nil)
    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

protocol ReminderViewDelegate {
  func reminderDataChanged(reminderSet: Bool, reminderDate: Date?)
}
