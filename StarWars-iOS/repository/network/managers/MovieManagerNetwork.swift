//
//  MovieManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation

class MovieManagerNetwork {
    static let shared = MovieManagerNetwork()
    let baseUrl = "https://swapi.dev/api/films"

    func getAllMovies(completion: @escaping (Result<[Film], Error>) -> Void) {
        guard let targetUrl = URL(string: baseUrl) else {return}
        NetworkManager.shared.get(MoviesList.self, from: targetUrl) { result in
            switch result {
            case .success(let result):
                completion(.success(result.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getAllMoviesAsync() async throws -> [Film] {
        do {
            guard let targetUrl = URL(string: baseUrl) else { throw NetworkError.networkError}
            let moviesList = try await NetworkManager.shared.getAsync(MoviesList.self, from: targetUrl)
            return moviesList.results
        } catch let error {
            throw error
        }
    }
}
