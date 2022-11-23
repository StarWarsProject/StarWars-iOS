//
//  Starship+CoreDataProperties.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//
//

import Foundation
import CoreData

extension Starship {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Starship> {
        return NSFetchRequest<Starship>(entityName: "Starship")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var model: String?
    @NSManaged public var manufacturer: String?
    @NSManaged public var length: String?
    @NSManaged public var maxAtmospheringSpeed: String?
    @NSManaged public var crew: String?
    @NSManaged public var passengers: String?
    @NSManaged public var cargoCapacity: String?
    @NSManaged public var starshipClass: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension Starship {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension Starship: Identifiable {

}
