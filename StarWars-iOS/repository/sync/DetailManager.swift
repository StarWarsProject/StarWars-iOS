//
//  CharacterManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation
import CoreData

enum DetailManagerError: Error {
    case NoMovieFound
    case NoCharactersAvailable
    case NoPlanetsAvailable
    case NoVehiclesAvailable
}

protocol DetailProtocolManager {
    func getCharactersByMovieAsync(idMovie: Int16) async -> Result<[Character], Error>
    func getPlanetsByMovieAsync(idMovie: Int16) async -> Result<[Planet], Error>
    func getSpeciesByMovieAsync(idMovie: Int16) async -> Result<[Specie], Error>
    func getStarshipsByMovieAsync(idMovie: Int16) async -> Result<[Starship], Error>
    func getVehiclesByMovieAsync(idMovie: Int16) async -> Result<[Vehicle], Error>
}

class DetaiManager: DetailProtocolManager {
    static let shared = DetaiManager()
    private let networkManager = DetailManagerNetwork.shared
    private let coreDataManager = CoreDataManager.shared
    private let localDataManager = DetailManagerLocal.shared

    func getDataForTabWithMovie<T: NSManagedObject>(idMovie: Int16, withEntity: CoreDataEntities) async -> EntitiesSearchResult<T>? {
        let movie: Movie? = coreDataManager.getEntityBy(id: "\(idMovie)", entity: .Movie)
        guard let safeMovie = movie else { return nil }
        var listID = [String]()
        switch withEntity {
        case .Movie:
            return nil
        case .Character:
            listID = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.charactersIds)
        case .Planet:
            listID = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.planetsIds)
        case .Specie:
            listID = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.speciesIds)
        case .Starship:
            listID = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.starshipsIds)
        case .Vehicle:
            listID = MovieManagerLocal.getIdsFromString(stringIds: "")
        }
        return coreDataManager.getEntitiesFromIDArray(listID, entity: withEntity)
    }

    func getCharactersByMovieAsync(idMovie: Int16) async -> Result<[Character], Error> {
        let movie: Movie? = coreDataManager.getEntityBy(id: "\(idMovie)", entity: .Movie)
        guard let safeMovie = movie else { return .failure(DetailManagerError.NoMovieFound) }
        let charsIds = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.charactersIds)
        let charactersByIDResult: EntitiesSearchResult<Character> = coreDataManager.getEntitiesFromIDArray(charsIds, entity: .Character)
        if charactersByIDResult.missingIds.isEmpty {
            return .success(charactersByIDResult.entities)
        }
        if Reachability.isConnectedToNetwork() {
            let newCharacters: Result<[CharacterResponse], Error> = await
            networkManager.getAllDataForTabIdAsync(idList: charactersByIDResult.missingIds, forTab: .people)
            switch newCharacters {
            case .success(let characters):
                localDataManager.saveAllCharactersByMovie(charactersList: characters, movie: safeMovie)
                localDataManager.syncCharactersWithMovie(characters: charactersByIDResult.entities, movie: safeMovie)
                return .success(safeMovie.charactersArray)
            case .failure(let failure):
                return .failure(failure)
            }
        }
        localDataManager.syncCharactersWithMovie(characters: charactersByIDResult.entities, movie: safeMovie)
        if safeMovie.charactersArray.isEmpty {
            return .failure(DetailManagerError.NoCharactersAvailable)
        }
        return .success(safeMovie.charactersArray)
    }

    func getPlanetsByMovieAsync(idMovie: Int16) async -> Result<[Planet], Error> {
        let movie: Movie? = coreDataManager.getEntityBy(id: "\(idMovie)", entity: .Movie)
        guard let safeMovie = movie else { return .failure(DetailManagerError.NoMovieFound) }
        let planetsIds = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.planetsIds)
        let planetsByIDResult: EntitiesSearchResult<Planet> = coreDataManager.getEntitiesFromIDArray(planetsIds, entity: .Planet)
        if planetsByIDResult.missingIds.isEmpty {
            return .success(planetsByIDResult.entities)
        }
        if Reachability.isConnectedToNetwork() {
            let newPlanets: Result<[PlanetResponse], Error> = await
            networkManager.getAllDataForTabIdAsync(idList: planetsByIDResult.missingIds, forTab: .planets)
            switch newPlanets {
            case .success(let planets):
                localDataManager.saveAllPlanetsByMovie(planetsList: planets, movie: safeMovie)
                localDataManager.syncPlanetsWithMovie(planets: planetsByIDResult.entities, movie: safeMovie)
                return .success(safeMovie.planetsArray)
            case .failure(let failure):
                return .failure(failure)
            }
        }
        localDataManager.syncPlanetsWithMovie(planets: planetsByIDResult.entities, movie: safeMovie)
        if safeMovie.planetsArray.isEmpty {
            return .failure(DetailManagerError.NoPlanetsAvailable)
        }
        return .success(safeMovie.planetsArray)
    }

    func getSpeciesByMovieAsync(idMovie: Int16) async -> Result<[Specie], Error> {
        let movie: Movie? = coreDataManager.getEntityBy(id: "\(idMovie)", entity: .Movie)
        guard let safeMovie = movie else { return .failure(DetailManagerError.NoMovieFound) }
        let speciesIds = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.speciesIds)
        let speciesByIDResult: EntitiesSearchResult<Specie> = coreDataManager.getEntitiesFromIDArray(speciesIds, entity: .Specie)
        if speciesByIDResult.missingIds.isEmpty {
            return .success(speciesByIDResult.entities)
        }
        if Reachability.isConnectedToNetwork() {
            let newSpecies: Result<[SpecieResponse], Error> = await
            networkManager.getAllDataForTabIdAsync(idList: speciesByIDResult.missingIds, forTab: .species)
            switch newSpecies {
            case .success(let species):
                localDataManager.saveAllSpeciesByMovie(speciesList: species, movie: safeMovie)
                localDataManager.syncSpeciesWithMovie(species: speciesByIDResult.entities, movie: safeMovie)
                return .success(safeMovie.speciesArray)
            case .failure(let failure):
                return .failure(failure)
            }
        }
        localDataManager.syncSpeciesWithMovie(species: speciesByIDResult.entities, movie: safeMovie)
        if safeMovie.speciesArray.isEmpty {
            return .failure(DetailManagerError.NoPlanetsAvailable)
        }
        return .success(safeMovie.speciesArray)
    }

    func getStarshipsByMovieAsync(idMovie: Int16) async -> Result<[Starship], Error> {
        let movie: Movie? = coreDataManager.getEntityBy(id: "\(idMovie)", entity: .Movie)
        guard let safeMovie = movie else { return .failure(DetailManagerError.NoMovieFound) }
        let shipIds = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.starshipsIds)
        let shipsByIDResult: EntitiesSearchResult<Starship> = coreDataManager.getEntitiesFromIDArray(shipIds, entity: .Starship)
        if shipsByIDResult.missingIds.isEmpty {
            return .success(shipsByIDResult.entities)
        }
        if Reachability.isConnectedToNetwork() {
            let newShips: Result<[StarshipsResponse], Error> = await
            networkManager.getAllDataForTabIdAsync(idList: shipsByIDResult.missingIds, forTab: .starships)
            switch newShips {
            case .success(let ships):
                localDataManager.saveAllShipsByMovie(shipList: ships, movie: safeMovie)
                localDataManager.syncShipsWithMovie(ships: shipsByIDResult.entities, movie: safeMovie)
                return .success(safeMovie.starshipsArray)
            case .failure(let failure):
                return .failure(failure)
            }
        }
        localDataManager.syncShipsWithMovie(ships: shipsByIDResult.entities, movie: safeMovie)
        if safeMovie.starshipsArray.isEmpty {
            return .failure(DetailManagerError.NoPlanetsAvailable)
        }
        return .success(safeMovie.starshipsArray)
    }

    func getVehiclesByMovieAsync(idMovie: Int16) async -> Result<[Vehicle], Error> {
        let movie: Movie? = coreDataManager.getEntityBy(id: "\(idMovie)", entity: .Movie)
        guard let safeMovie = movie else { return .failure(DetailManagerError.NoMovieFound) }
        let vehiclesIds = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.vehiclesIds)
        let vehiclesByIDResult: EntitiesSearchResult<Vehicle> = coreDataManager.getEntitiesFromIDArray(vehiclesIds, entity: .Vehicle)
        if vehiclesByIDResult.missingIds.isEmpty {
            return .success(vehiclesByIDResult.entities)
        } else {
            if Reachability.isConnectedToNetwork() {
                let newVehicles: Result<[VehicleResponse], Error> = await
                networkManager.getAllDataForTabIdAsync(idList: vehiclesByIDResult.missingIds, forTab: .vehicles)
                switch newVehicles {
                case .success(let vehicles):
                    localDataManager.saveAllVehiclesByMovie(vehiclesList: vehicles, movie: safeMovie)
                    localDataManager.syncVehiclesWithMovie(vehicles: vehiclesByIDResult.entities, movie: safeMovie)
                    return .success(safeMovie.vehiclesArray)
                case .failure(let failure):
                    return .failure(failure)
                }
            }
            localDataManager.syncVehiclesWithMovie(vehicles: vehiclesByIDResult.entities, movie: safeMovie)
            if safeMovie.vehiclesArray.isEmpty {
                return .failure(DetailManagerError.NoVehiclesAvailable)
            }
            return .success(safeMovie.vehiclesArray)
        }
    }
}
