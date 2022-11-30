//
//  CharacterManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation

class CharacterManager {
    static let shared = CharacterManager()
    func getCharactersByMovieAsync(characterUrlList: [String], movie: Movie) async throws -> [Character] {
        do {
            let characters = try await CharacterManagerNetwork.shared.getAllCharactersByMovieAsync(characterUrlList: characterUrlList)
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
