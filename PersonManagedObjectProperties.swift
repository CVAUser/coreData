//
//  PersonMO+CoreDataProperties.swift
//  Core Data
//
//  Created by Slava on 05.11.2021.
//
//

import Foundation
import CoreData


extension PersonMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonMO> {
        return NSFetchRequest<PersonMO>(entityName: "Person")
    }

    @NSManaged public var name: String?

}
