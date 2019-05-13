//
//  IntersetingPlace.swift
//  InterestingPlaces
//
//  Created by Brian on 10/3/18.
//  Copyright © 2018 Razeware LLC. All rights reserved.
//

import Foundation
import CoreLocation

class InterestingPlace {
  
  var location: CLLocation?
  var address: String
  let name: String
  let imageName: String
  
  init(address: String, name: String, imageName: String) {
    self.address = address
    self.name = name
    self.imageName = imageName
  }
  
  
  
}
