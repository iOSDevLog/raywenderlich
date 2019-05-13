//
//  ParkOverlay.swift
//  Park View
//
//  Created by Brian on 10/22/18.
//  Copyright © 2018 Chris Wagner. All rights reserved.
//

import UIKit
import MapKit

class ParkOverlay: NSObject, MKOverlay {

  var coordinate: CLLocationCoordinate2D
  var boundingMapRect: MKMapRect
  
  init(park: Park) {
    boundingMapRect = park.overlayBoundingMapRect
    coordinate = park.midCoordinate
  }
  
}
