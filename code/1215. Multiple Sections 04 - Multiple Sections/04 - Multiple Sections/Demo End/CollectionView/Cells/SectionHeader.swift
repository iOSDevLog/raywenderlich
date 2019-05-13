//
//  SectionHeader.swift
//  CollectionView
//
//  Created by Catie Catterwaul on 9/17/17.
//  Copyright © 2017 Razeware. All rights reserved.
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
