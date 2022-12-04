//
//  PlanetManagerNetwork.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 30/11/22.
//

import Foundation

class PlanetManagerNetwork {
    static let shared = PlanetManagerNetwork()
    let baseUrl = "https://swapi.dev/api/planets"

    func getAllPlanetByMovie(completion: @escaping (Result<PlanetResponse, Error>) -> Void) {
        guard let targetUrl = URL(string: baseUrl) else {return}
        NetworkManager.shared.get(PlanetResponse.self, from: targetUrl) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getPlanetAsync(planetUrl: String) async throws -> PlanetResponse {
        do {
            guard let targetUrl = URL(string: planetUrl) else { throw NetworkError.networkError}
            let planet = try await NetworkManager.shared.getAsync(PlanetResponse.self, from: targetUrl)
            return planet
        } catch let error {
            throw error
        }
    }

    func getAllPlanetsByMovieAsync(planetsIdsList: [String]) async throws -> [PlanetResponse] {
        do {
            var finalPlanetsList = [PlanetResponse]()
            for id in planetsIdsList {
                let url = "\(self.baseUrl)/\(id)"
                let planet = try await getPlanetAsync(planetUrl: url)
                finalPlanetsList.append(planet)
            }
            return finalPlanetsList
        } catch let error {
            throw error
        }
    }
}
