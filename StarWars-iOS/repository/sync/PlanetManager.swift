//
//  PlanetManager.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 30/11/22.
//

import Foundation

class PlanetManager {
    static let shared = PlanetManager()
    func getPlanetsByMovieAsync(movie: Movie) async throws -> [Planet] {
        do {
            let platIds = MovieManagerLocal.getIdsFromString(stringIds: movie.planetsIds)
            let planets = try await PlanetManagerNetwork.shared.getAllPlanetsByMovieAsync(planetsIdsList: platIds)
            PlanetManagerLocal.shared.deletePlanetsByMovie(movie: movie)
            PlanetManagerLocal.shared.saveAllPlanetsByMovie(planetsList: planets, movie: movie)
            return movie.planetsArray
        } catch let error {
            let planets = movie.planetsArray
            if planets.isEmpty {
                throw error
            } else {
                return planets
            }
        }
    }
}
