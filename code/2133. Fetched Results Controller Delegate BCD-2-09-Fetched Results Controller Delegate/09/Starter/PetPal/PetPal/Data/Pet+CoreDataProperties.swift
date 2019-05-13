//
//  Pet+CoreDataProperties.swift
//  PetPal
//
//  Created by Brian on 8/8/18.
//  Copyright © 2018 Razeware. All rights reserved.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var name: String
    @NSManaged public var kind: String
    @NSManaged public var picture: NSData?
    @NSManaged public var dob: NSDate?
    @NSManaged public var owner: Friend

}
