//
//  FlowLayout.swift
//  CollectionView
//
//  Created by Catie Catterwaul on 9/17/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {
	var addedItem: IndexPath?
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		var result = [UICollectionViewLayoutAttributes]()
		if let attributes = super.layoutAttributesForElements(in: rect) {
			for item in attributes {
				let cellAttributes = item.copy() as! UICollectionViewLayoutAttributes
				if item.representedElementKind == nil {
					let frame = cellAttributes.frame
					cellAttributes.frame = frame.insetBy(dx: 2.0, dy: 2.0)
				}
				result.append(cellAttributes)
			}
		}
		
		return result
	}
	
	override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath),
		let added = addedItem,
			added == itemIndexPath else {
				return nil
		}
		// set new attributes
		attributes.center = CGPoint(x: collectionView!.frame.width - 23.5, y: -24.5)
		attributes.alpha = 1.0
		attributes.transform = CGAffineTransform(scaleX: 0.15, y: 0.15)
		attributes.zIndex = 50
		
		return attributes
	}
}
