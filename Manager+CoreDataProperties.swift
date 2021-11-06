//
//  Manager+CoreDataProperties.swift
//  Core Data
//
//  Created by Slava on 06.11.2021.
//
//

import Foundation
import CoreData


extension Manager {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Manager> {
        return NSFetchRequest<Manager>(entityName: "Manager")
    }

    @NSManaged public var group: Int32

}
