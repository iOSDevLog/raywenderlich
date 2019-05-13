//
//  Friend+CoreDataClass.swift
//  PetPal
//
//  Created by Brian on 8/1/18.
//  Copyright © 2018 Razeware. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


public class Friend: NSManagedObject {

  var age: Int {
    if let dob = dob as Date? {
      return Calendar.current.dateComponents([.year], from: dob, to: Date()).year!
    }
    return 0
  }
  
  var eyeColorString: String {
    guard let color = eyeColor as? UIColor else {
      return "No Color"
    }
    switch color {
    case UIColor.black:
      return "Black"
    case UIColor.blue:
      return "Blue"
    case UIColor.brown:
      return "Brown"
    case UIColor.green:
      return "Green"
    case UIColor.gray:
      return "Gray"
    default:
      return "Unknown"
    }
  }

}
