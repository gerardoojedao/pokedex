//
//  Property+CoreDataProperties.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 21-09-22.
//
//

import Foundation
import CoreData


extension Property {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Property> {
        return NSFetchRequest<Property>(entityName: "Property")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?

}

extension Property : Identifiable {

}
