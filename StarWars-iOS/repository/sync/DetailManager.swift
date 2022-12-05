//
//  CharacterManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation

enum DetailManagerError: Error {
    case NoMovieFound
    case NoCharactersAvailable
    case NoPlanetsAvailable
    case NoVehiclesAvailable
}

protocol DetailProtocolManager {
    func getCharactersByMovieAsync(idMovie: Int16) async -> Result<[Character], Error>
    func getPlanetsByMovieAsync(idMovie: Int16) async -> Result<[Planet], Error>
    func getVehiclesByMovieAsync(idMovie: Int16) async -> Result<[Vehicle], Error>
}

class DetaiManager: DetailProtocolManager {
    static let shared = DetaiManager()
    private let networkManager = DetailManagerNetwork.shared
    private let coreDataManager = CoreDataManager.shared
    private let localDataManager = DetailManagerLocal.shared

    func getCharactersByMovieAsync(idMovie: Int16) async -> Result<[Character], Error> {

        let movie: Movie? = coreDataManager.getEntityBy(id: "\(idMovie)", entity: .Movie)
        guard let safeMovie = movie else { return .failure(DetailManagerError.NoMovieFound) }
        let charsIds = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.charactersIds)
        let charactersByIDResult: EntitiesSearchResult<Character> = coreDataManager.getEntitiesFromIDArray(charsIds, entity: .Character)
        if charactersByIDResult.missingIds.isEmpty {
            return .success(charactersByIDResult.entities)
        } else {
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
    }

    func getPlanetsByMovieAsync(idMovie: Int16) async -> Result<[Planet], Error> {

        let movie: Movie? = coreDataManager.getEntityBy(id: "\(idMovie)", entity: .Movie)
        guard let safeMovie = movie else { return .failure(DetailManagerError.NoMovieFound) }
        let planetsIds = MovieManagerLocal.getIdsFromString(stringIds: safeMovie.planetsIds)
        let planetsByIDResult: EntitiesSearchResult<Planet> = coreDataManager.getEntitiesFromIDArray(planetsIds, entity: .Planet)
        if planetsByIDResult.missingIds.isEmpty {
            return .success(planetsByIDResult.entities)
        } else {
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
            if safeMovie.charactersArray.isEmpty {
                return .failure(DetailManagerError.NoPlanetsAvailable)
            }
            return .success(safeMovie.planetsArray)
        }
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
