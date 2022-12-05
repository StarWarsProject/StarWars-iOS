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
            let newCharacter = Character(context: CoreDataManager.shared.getContext())
            newCharacter.name = character.name
            newCharacter.birth = character.birthYear
            newCharacter.createdAt = Date()
            newCharacter.desc = ""
            newCharacter.gender = character.gender
            newCharacter.height = character.height
            var idChar = character.url
            idChar.removeLast()
            newCharacter.id = Int16(String(idChar[(idChar.index(after: idChar.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idChar)))...])) ?? 0
            newCharacter.image = ""
            newCharacter.planet = ""
            newCharacter.specie = ""
            newCharacter.updatedAt = Date()
            newCharacter.addToMovies(movie)
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

    func deleteCharactersByMovie(movie: Movie) {
        let charsIds = MovieManagerLocal.getIdsFromString(stringIds: movie.charactersIds)
        charsIds.forEach { id in
            coreDataManager.deleteEntityObjectByKeyValue(entity: .Character, key: "id", value: id)
        }
    }

    func saveAllVehiclesByMovie(vehiclesList: [VehicleResponse], movie: Movie) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Save Vehicles
        vehiclesList.forEach { vehicle in
            let newVehicle = Vehicle(context: CoreDataManager.shared.getContext())
            newVehicle.name = vehicle.name
            newVehicle.createdAt = Date()
            newVehicle.cargoCapacity = vehicle.cargoCapacity
            newVehicle.crew = vehicle.crew
            newVehicle.length = vehicle.length
            newVehicle.manufacturer = vehicle.manufacturer
            newVehicle.maxAtmospheringSpeed = vehicle.maxAtmospheringSpeed
            newVehicle.model = vehicle.model
            newVehicle.passengers = vehicle.passengers
            newVehicle.vehicleClass = vehicle.vehicleClass
            var idVeh = vehicle.url
            idVeh.removeLast()
            newVehicle.id = Int16(String(idVeh[(idVeh.index(after: idVeh.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idVeh)))...])) ?? 0
            newVehicle.updatedAt = Date()
            newVehicle.addToMovies(movie)
            coreDataManager.saveContext()
        }
    }

    func syncVehiclesWithMovie(vehicles: [Vehicle], movie: Movie) {
        for vehicle in vehicles {
            vehicle.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }
}
