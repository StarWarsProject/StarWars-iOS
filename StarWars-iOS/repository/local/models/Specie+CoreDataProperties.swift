//
//  Specie+CoreDataProperties.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//
//

import Foundation
import CoreData

extension Specie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Specie> {
        return NSFetchRequest<Specie>(entityName: "Specie")
    }

    @NSManaged public var classification: String
    @NSManaged public var createdAt: Date
    @NSManaged public var desc: String
    @NSManaged public var id: Int16
    @NSManaged public var image: String
    @NSManaged public var language: String
    @NSManaged public var name: String
    @NSManaged public var planet: String
    @NSManaged public var updatedAt: Date
    @NSManaged public var movies: NSSet

    public var moviesArray: [Movie] {
        let set = movies as? Set<Movie> ?? []
        return set.sorted {
            $0.createdAt < $1.createdAt
        }
    }

}

// MARK: Generated accessors for movies
extension Specie {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension Specie: Identifiable {

}
