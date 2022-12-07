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
        let context = coreDataManager.getContext()
        charactersList.forEach { character in
            let newCharacter = character.toEntity(context: context)
            newCharacter.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func syncCharactersWithMovie(characters: [Character], movie: Movie) {
        coreDataManager.getContext()
        for character in characters {
            character.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func saveAllPlanetsByMovie(planetsList: [PlanetResponse], movie: Movie) {
        let context = coreDataManager.getContext()
        planetsList.forEach { planet in
            let newPlanet = planet.toEntity(context: context)
            newPlanet.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func syncPlanetsWithMovie(planets: [Planet], movie: Movie) {
        coreDataManager.getContext()
        for planet in planets {
            planet.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func saveAllSpeciesByMovie(speciesList: [SpecieResponse], movie: Movie) {
        let context = coreDataManager.getContext()
        speciesList.forEach { specie in
            let newSpecie = specie.toEntity(context: context)
            newSpecie.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func syncSpeciesWithMovie(species: [Specie], movie: Movie) {
        coreDataManager.getContext()
        for specie in species {
            specie.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func saveAllShipsByMovie(shipList: [StarshipsResponse], movie: Movie) {
        let context = coreDataManager.getContext()
        shipList.forEach { ship in
            let newShip = ship.toEntity(context: context)
            newShip.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func syncShipsWithMovie(ships: [Starship], movie: Movie) {
        coreDataManager.getContext()
        for ship in ships {
            ship.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func saveAllVehiclesByMovie(vehiclesList: [VehicleResponse], movie: Movie) {
        let context = coreDataManager.getContext()
        vehiclesList.forEach { vehicle in
            let newVehicle = vehicle.toEntity(context: context)
            newVehicle.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }

    func syncVehiclesWithMovie(vehicles: [Vehicle], movie: Movie) {
        coreDataManager.getContext()
        for vehicle in vehicles {
            vehicle.addToMovies(movie)
        }
        coreDataManager.saveContext()
    }
}
