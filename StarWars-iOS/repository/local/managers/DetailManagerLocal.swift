//
//  CharacterManagerLocal.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation

class DetailManagerLocal {
    static let shared = DetailManagerLocal()
    private let coreDataManager = CoreDataManager.shared

    func saveAllCharactersByMovie(charactersList: [CharacterResponse], movie: Movie) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Save Characters
        charactersList.forEach { character in
            let newCharacter = character.toEntity(context: coreDataManager.getContext()) as? Character
            if let safeCharacter = newCharacter {
                safeCharacter.addToMovies(movie)
            }
        }
        coreDataManager.saveContext()
    }

    func syncCharactersWithMovie(characters: [Character], movie: Movie) {
        for character in characters {
            character.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func saveAllPlanetsByMovie(planetsList: [PlanetResponse], movie: Movie) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Save Planets
        planetsList.forEach { planet in
            let newPlanet = Planet(context: CoreDataManager.shared.getContext())
            newPlanet.name = planet.name
            newPlanet.createdAt = Date()
            newPlanet.desc = ""
            newPlanet.region = ""
            newPlanet.system = ""
            newPlanet.climate = planet.climate
            newPlanet.terrain = planet.terrain
            newPlanet.population = planet.population
            var idPlan = planet.url
            idPlan.removeLast()
            newPlanet.id = Int16(String(idPlan[(idPlan.index(after: idPlan.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idPlan)))...])) ?? 0
            newPlanet.image = ""
            newPlanet.updatedAt = Date()
            newPlanet.addToMovies(movie)
            coreDataManager.saveContext()
        }
    }

    func syncPlanetsWithMovie(planets: [Planet], movie: Movie) {
        for planet in planets {
            planet.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func saveAllSpeciesByMovie(speciesList: [SpecieResponse], movie: Movie) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        speciesList.forEach { specie in
            let newSpecie = Specie(context: CoreDataManager.shared.getContext())
            newSpecie.name = specie.name
            newSpecie.createdAt = Date()
            newSpecie.desc = ""
            newSpecie.classification = specie.classification
            newSpecie.language = specie.language
            newSpecie.planet = ""
            var idSpe = specie.url
            idSpe.removeLast()
            newSpecie.id = Int16(String(idSpe[(idSpe.index(after: idSpe.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idSpe)))...])) ?? 0
            newSpecie.image = ""
            newSpecie.updatedAt = Date()
            newSpecie.addToMovies(movie)
            coreDataManager.saveContext()
        }
    }

    func syncSpeciesWithMovie(species: [Specie], movie: Movie) {
        for specie in species {
            specie.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func saveAllShipsByMovie(shipList: [StarshipsResponse], movie: Movie) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        shipList.forEach { ship in
            let newShip = Starship(context: coreDataManager.getContext())
            newShip.name = ship.name
            newShip.model = ship.model
            newShip.manufacturer = ship.manufacturer
            newShip.length = ship.length
            newShip.maxAtmospheringSpeed = ship.maxAtmospheringSpeed
            newShip.crew = ship.crew
            newShip.passengers = ship.passengers
            newShip.cargoCapacity = ship.cargoCapacity
            newShip.starshipClass = ship.starshipClass
            newShip.createdAt = Date()
            var idShip = ship.url
            idShip.removeLast()
            newShip.id = Int16(String(idShip[(idShip.index(after: idShip.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idShip)))...])) ?? 0
            newShip.updatedAt = Date()
            newShip.addToMovies(movie)
            coreDataManager.saveContext()
        }
    }

    func syncShipsWithMovie(ships: [Starship], movie: Movie) {
        for ship in ships {
            ship.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func deleteCharactersByMovie(movie: Movie) {
        let charsIds = MovieManagerLocal.getIdsFromString(stringIds: movie.charactersIds)
        charsIds.forEach { id in
            coreDataManager.deleteEntityObjectByKeyValue(entity: .Character, key: "id", value: id)
        }
    }
}
