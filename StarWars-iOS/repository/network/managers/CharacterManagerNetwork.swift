//
//  CharacterManagerNetwork.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation

class CharacterManagerNetwork {
    static let shared = CharacterManagerNetwork()
    let baseUrl = "https://swapi.dev/api/people"

    func getAllCharacterByMovie(completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        guard let targetUrl = URL(string: baseUrl) else {return}
        NetworkManager.shared.get(CharacterResponse.self, from: targetUrl) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCharacterAsync(characterUrl: String) async throws -> CharacterResponse {
        do {
            guard let targetUrl = URL(string: characterUrl) else { throw NetworkError.networkError}
            let character = try await NetworkManager.shared.getAsync(CharacterResponse.self, from: targetUrl)
            return character
        } catch let error {
            throw error
        }
    }

    func getAllCharactersByMovieAsync(charactersIdsList: [String]) async throws -> [CharacterResponse] {
        do {
            var finalCharactersList = [CharacterResponse]()
            for id in charactersIdsList {
                let url = "\(self.baseUrl)/\(id)"
                let character = try await getCharacterAsync(characterUrl: url)
                finalCharactersList.append(character)
            }
            return finalCharactersList
        } catch let error {
            throw error
        }
    }
}
