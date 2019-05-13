//
//  SectionHeader.swift
//  CollectionView
//
//  Created by Brian on 7/18/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  
}
