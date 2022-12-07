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
        charactersList.forEach { character in
            let newCharacter = character.toEntity(context: coreDataManager.getContext())
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
        planetsList.forEach { planet in
            let newPlanet = planet.toEntity(context: coreDataManager.getContext())
            newPlanet.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func syncPlanetsWithMovie(planets: [Planet], movie: Movie) {
        for planet in planets {
            planet.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func saveAllSpeciesByMovie(speciesList: [SpecieResponse], movie: Movie) {
        speciesList.forEach { specie in
            let newSpecie = specie.toEntity(context: coreDataManager.getContext())
            newSpecie.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func syncSpeciesWithMovie(species: [Specie], movie: Movie) {
        for specie in species {
            specie.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func saveAllShipsByMovie(shipList: [StarshipsResponse], movie: Movie) {
        shipList.forEach { ship in
            let newShip = ship.toEntity(context: coreDataManager.getContext())
            newShip.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func syncShipsWithMovie(ships: [Starship], movie: Movie) {
        for ship in ships {
            ship.addToMovies(movie)
        }
        coreDataManager.saveContext()
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
