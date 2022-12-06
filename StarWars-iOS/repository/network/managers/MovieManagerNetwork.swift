//
//  MovieManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation

class MovieManagerNetwork {
    static let shared = MovieManagerNetwork()

    private let endpointURL = "/films"
    private let networkManager = NetworkManager.shared

    func getAllMoviesAsync() async -> Result<[Film], Error> {
        do {
            let result: Result<MoviesList, Error> = try await networkManager.getAsyncAwait(url: endpointURL)
            switch result {
            case .success(let success):
                return .success(success.results)
            case .failure(let failure):
                return .failure(failure)
            }
        } catch {
            return .failure(NetworkError.NetworkError(msg: error.localizedDescription))
        }
    }
}
