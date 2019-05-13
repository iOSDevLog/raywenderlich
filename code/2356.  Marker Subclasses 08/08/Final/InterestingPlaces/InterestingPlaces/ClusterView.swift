//
//  ClusterView.swift
//  InterestingPlaces
//
//  Created by Brian on 10/22/18.
//  Copyright © 2018 Razeware LLC. All rights reserved.
//

import UIKit
import MapKit

class ClusterView: MKMarkerAnnotationView {

  override var annotation: MKAnnotation? {
    willSet {
      markerTintColor = UIColor.brown
    }
  }
  
}
