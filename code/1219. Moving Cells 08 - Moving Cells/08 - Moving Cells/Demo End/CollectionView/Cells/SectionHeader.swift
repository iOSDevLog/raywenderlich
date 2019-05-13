//
//  SectionHeader.swift
//  CollectionView
//
//  Created by Catie Catterwaul on 9/17/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
	@IBOutlet private weak var flagImage: UIImageView!
	@IBOutlet private weak var countLabel: UILabel!
	@IBOutlet private weak var titleLabel: UILabel!
	
	var section: Section! {
		didSet {
			titleLabel.text = section.title
			flagImage.image = UIImage(named: section.title ?? "")
			countLabel.text = "\(section.count)"
		}
	}
}
