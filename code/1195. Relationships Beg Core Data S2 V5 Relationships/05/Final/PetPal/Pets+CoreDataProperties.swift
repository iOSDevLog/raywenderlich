//
//  Pets+CoreDataProperties.swift
//  PetPal
//
//  Created by Brian on 9/20/17.
//  Copyright © 2017 Razeware. All rights reserved.
//
//

import Foundation
import CoreData


extension Pets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pets> {
        return NSFetchRequest<Pets>(entityName: "Pets")
    }

    @NSManaged public var dob: NSDate?
    @NSManaged public var kind: String?
    @NSManaged public var name: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var owner: Friend

}
