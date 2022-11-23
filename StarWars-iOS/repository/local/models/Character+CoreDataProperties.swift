//
//  Character+CoreDataProperties.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//
//

import Foundation
import CoreData

extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var birth: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var desc: String?
    @NSManaged public var gender: String?
    @NSManaged public var height: String?
    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var planet: String?
    @NSManaged public var specie: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension Character {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension Character: Identifiable {

}
