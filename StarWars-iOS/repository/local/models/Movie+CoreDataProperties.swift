//
//  Movie+CoreDataProperties.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 30/11/22.
//
//

import Foundation
import CoreData

extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var charactersIds: String
    @NSManaged public var createdAt: Date
    @NSManaged public var director: String
    @NSManaged public var id: Int16
    @NSManaged public var openingCrawl: String
    @NSManaged public var producer: String
    @NSManaged public var releaseDate: Date
    @NSManaged public var title: String
    @NSManaged public var updatedAt: Date
    @NSManaged public var episodeId: Int16
    @NSManaged public var characters: NSSet
    @NSManaged public var planetsIds: String
    @NSManaged public var planets: NSSet
    @NSManaged public var speciesIds: String
    @NSManaged public var starshipsIds: String
    @NSManaged public var species: NSSet
    @NSManaged public var starships: NSSet
    @NSManaged public var vehicles: NSSet

    public var charactersArray: [Character] {
        let set = characters as? Set<Character> ?? []
        return set.sorted {
            $0.createdAt < $1.createdAt
        }
    }

    public var planetsArray: [Planet] {
        let set = planets as? Set<Planet> ?? []
        return set.sorted {
            $0.createdAt < $1.createdAt
        }
    }

    public var speciesArray: [Specie] {
        let set = species as? Set<Specie> ?? []
        return set.sorted {
            $0.createdAt < $1.createdAt
        }
    }

    public var starshipsArray: [Starship] {
        let set = starships as? Set<Starship> ?? []
        return set.sorted {
            $0.createdAt < $1.createdAt
        }
    }
}

// MARK: Generated accessors for characters
extension Movie {

    @objc(addCharactersObject:)
    @NSManaged public func addToCharacters(_ value: Character)

    @objc(removeCharactersObject:)
    @NSManaged public func removeFromCharacters(_ value: Character)

    @objc(addCharacters:)
    @NSManaged public func addToCharacters(_ values: NSSet)

    @objc(removeCharacters:)
    @NSManaged public func removeFromCharacters(_ values: NSSet)

}

// MARK: Generated accessors for planets
extension Movie {

    @objc(addPlanetsObject:)
    @NSManaged public func addToPlanets(_ value: Planet)

    @objc(removePlanetsObject:)
    @NSManaged public func removeFromPlanets(_ value: Planet)

    @objc(addPlanets:)
    @NSManaged public func addToPlanets(_ values: NSSet)

    @objc(removePlanets:)
    @NSManaged public func removeFromPlanets(_ values: NSSet)

}

// MARK: Generated accessors for species
extension Movie {

    @objc(addSpeciesObject:)
    @NSManaged public func addToSpecies(_ value: Specie)

    @objc(removeSpeciesObject:)
    @NSManaged public func removeFromSpecies(_ value: Specie)

    @objc(addSpecies:)
    @NSManaged public func addToSpecies(_ values: NSSet)

    @objc(removeSpecies:)
    @NSManaged public func removeFromSpecies(_ values: NSSet)

}

// MARK: Generated accessors for starships
extension Movie {

    @objc(addStarshipsObject:)
    @NSManaged public func addToStarships(_ value: Starship)

    @objc(removeStarshipsObject:)
    @NSManaged public func removeFromStarships(_ value: Starship)

    @objc(addStarships:)
    @NSManaged public func addToStarships(_ values: NSSet)

    @objc(removeStarships:)
    @NSManaged public func removeFromStarships(_ values: NSSet)

}

// MARK: Generated accessors for vehicles
extension Movie {

    @objc(addVehiclesObject:)
    @NSManaged public func addToVehicles(_ value: Vehicle)

    @objc(removeVehiclesObject:)
    @NSManaged public func removeFromVehicles(_ value: Vehicle)

    @objc(addVehicles:)
    @NSManaged public func addToVehicles(_ values: NSSet)

    @objc(removeVehicles:)
    @NSManaged public func removeFromVehicles(_ values: NSSet)

}

extension Movie: Identifiable {
}
