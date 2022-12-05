//
//  MovieManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation

enum MovieManagerError: Error {
case NoDataAvailable
}

protocol MovieManagerProtocol {
    func getAllMoviesAsync() async -> Result<[Movie], Error>
}

class MovieManager: MovieManagerProtocol {
    static let shared = MovieManager()
    private let networkManager = MovieManagerNetwork.shared
    private let coreDataManager = CoreDataManager.shared
    private let localDataManager = MovieManagerLocal.shared

    func getAllMoviesAsync() async -> Result<[Movie], Error> {

        if Reachability.isConnectedToNetwork() {
            let films = await networkManager.getAllMoviesAsync()
            switch films {
            case .success(let films):
                coreDataManager.deleteAll()
                localDataManager.saveMovies(films: films)
            case .failure(let failure):
                return .failure(failure)
            }
        }
        let movies = localDataManager.getMovies()
        if movies.isEmpty {
            return .failure(MovieManagerError.NoDataAvailable)
        }
        return .success(movies)
    }
}
