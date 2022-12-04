//
//  Planet+CoreDataProperties.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//
//

import Foundation
import CoreData

extension Planet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Planet> {
        return NSFetchRequest<Planet>(entityName: "Planet")
    }

    @NSManaged public var createdAt: Date
    @NSManaged public var desc: String
    @NSManaged public var id: Int16
    @NSManaged public var image: String
    @NSManaged public var name: String
    @NSManaged public var region: String
    @NSManaged public var system: String
    @NSManaged public var climate: String
    @NSManaged public var terrain: String
    @NSManaged public var population: String
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
extension Planet {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension Planet: Identifiable {

}
