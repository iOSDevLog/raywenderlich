//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Brian on 6/19/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import Foundation

class ChecklistItem {
  
  var text = ""
  var checked = false
  
  func toggleChecked() {
    checked = !checked
  }
  
}


