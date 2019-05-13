//
//  BugSection.swift
//  ScaryBugs
//
//  Created by Brian on 10/27/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation

class BugSection {
  
  let howScary: ScaryFactor
  var bugs = [ScaryBug]()
  
  init(howScary: ScaryFactor) {
    self.howScary = howScary
  }
}