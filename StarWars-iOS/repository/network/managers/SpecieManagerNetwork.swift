//
//  SpecieManagerNetwork.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 2/12/22.
//

import Foundation

class SpecieManagerNetwork {
    static let shared = SpecieManagerNetwork()
    let baseUrl = "https://swapi.dev/api/species"

    func getAllSpecieByMovie(completion: @escaping (Result<SpecieResponse, Error>) -> Void) {
        guard let targetUrl = URL(string: baseUrl) else {return}
        NetworkManager.shared.get(SpecieResponse.self, from: targetUrl) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getSpecieAsync(specieUrl: String) async throws -> SpecieResponse {
        do {
            guard let targetUrl = URL(string: specieUrl) else { throw NetworkError.networkError}
            let specie = try await NetworkManager.shared.getAsync(SpecieResponse.self, from: targetUrl)
            return specie
        } catch let error {
            throw error
        }
    }

    func getAllSpeciesByMovieAsync(speciesIdsList: [String]) async throws -> [SpecieResponse] {
        do {
            var finalSpeciesList = [SpecieResponse]()
            for id in speciesIdsList {
                let url = "\(self.baseUrl)/\(id)"
                let specie = try await getSpecieAsync(specieUrl: url)
                finalSpeciesList.append(specie)
            }
            return finalSpeciesList
        } catch let error {
            throw error
        }
    }
}
