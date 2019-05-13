//
//  ScaryBugTableViewCell.swift
//  ScaryBugs
//
//  Created by Brian on 10/28/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ScaryBugTableViewCell: UITableViewCell {
  
  @IBOutlet weak var bugImageView: UIImageView!
  @IBOutlet weak var bugNameLabel: UILabel!
  @IBOutlet weak var howScaryImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
