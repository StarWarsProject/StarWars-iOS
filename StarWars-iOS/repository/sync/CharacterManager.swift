//
//  CharacterManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation

class CharacterManager {
    static let shared = CharacterManager()
    func getCharactersByMovieAsync(movie: Movie) async throws -> [Character] {
        do {
            let charsIds = MovieManagerLocal.getIdsFromString(stringIds: movie.charactersIds)
            let characters = try await CharacterManagerNetwork.shared.getAllCharactersByMovieAsync(charactersIdsList: charsIds)
            CharacterManagerLocal.shared.deleteCharactersByMovie(movie: movie)
            CharacterManagerLocal.shared.saveAllCharactersByMovie(charactersList: characters, movie: movie)
            return movie.charactersArray
        } catch let error {
            let characters = movie.charactersArray
            if characters.isEmpty {
                throw error
            } else {
                return characters
            }
        }
    }
}
