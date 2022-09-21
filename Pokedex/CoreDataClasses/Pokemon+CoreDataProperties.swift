//
//  Pokemon+CoreDataProperties.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 21-09-22.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int16
    @NSManaged public var url: String?
    @NSManaged public var types: NSSet?
    @NSManaged public var evolution: Property?
    @NSManaged public var moves: NSSet?

}

// MARK: Generated accessors for types
extension Pokemon {

    @objc(addTypesObject:)
    @NSManaged public func addToTypes(_ value: Property)

    @objc(removeTypesObject:)
    @NSManaged public func removeFromTypes(_ value: Property)

    @objc(addTypes:)
    @NSManaged public func addToTypes(_ values: NSSet)

    @objc(removeTypes:)
    @NSManaged public func removeFromTypes(_ values: NSSet)

}

// MARK: Generated accessors for moves
extension Pokemon {

    @objc(addMovesObject:)
    @NSManaged public func addToMoves(_ value: Property)

    @objc(removeMovesObject:)
    @NSManaged public func removeFromMoves(_ value: Property)

    @objc(addMoves:)
    @NSManaged public func addToMoves(_ values: NSSet)

    @objc(removeMoves:)
    @NSManaged public func removeFromMoves(_ values: NSSet)

}

extension Pokemon : Identifiable {

}
