//
//  MovieManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation

class MovieManager {
    static let shared = MovieManager()

    func getAllMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        MovieManagerNetwork.shared.getAllMovies { result in
            switch result {
            case .success(let films):
                CoreDataManager.shared.deleteAll()
                MovieManagerLocal.shared.saveMovies(films: films)
                let localDbMovies = MovieManagerLocal.shared.getMovies()
                completion(.success(localDbMovies))
            case .failure(let error):
                let localDbMovies = MovieManagerLocal.shared.getMovies()
                if localDbMovies.isEmpty {
                    completion(.failure(error))
                } else {
                    completion(.success(localDbMovies))
                }
            }
        }
    }

    func getAllMoviesAsync() async throws -> [Movie] {
        do {
            let films = try await MovieManagerNetwork.shared.getAllMoviesAsync()
            CoreDataManager.shared.deleteAll()
            MovieManagerLocal.shared.saveMovies(films: films)
            let movies = MovieManagerLocal.shared.getMovies()
            let charsUrls = films.map { film in
                film.characters
            }
            return movies
        } catch let error {
            let movies = MovieManagerLocal.shared.getMovies()
            if movies.isEmpty {
                throw error
            } else {
                return movies
            }
        }
    }
}
