//
//  CharacterManagerLocal.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation

class CharacterManagerLocal {
    static let shared = CharacterManagerLocal()

    func saveAllCharactersByMovie(charactersList: [CharacterResponse], movie: Movie) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Save Characters
        charactersList.forEach { character in
            let newCharacter = Character(context: CoreDataManager.shared.getContext())
            newCharacter.name = character.name
            newCharacter.birth = character.birthYear
            newCharacter.createdAt = Date()
            newCharacter.desc = ""
            newCharacter.gender = character.gender
            newCharacter.height = character.height
            var idChar = character.url
            idChar.removeLast()
            newCharacter.id = Int16(String(idChar[(idChar.index(after: idChar.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idChar)))...])) ?? 0
            newCharacter.image = ""
            newCharacter.planet = ""
            newCharacter.specie = ""
            newCharacter.updatedAt = Date()
            newCharacter.addToMovies(movie)
            CoreDataManager.shared.saveContext()
        }
    }

    func deleteCharactersByMovie(movie: Movie) {
        let charsIds = MovieManagerLocal.getIdsFromString(stringIds: movie.charactersIds)
        charsIds.forEach { id in
            CoreDataManager.shared.deleteEntityObjectByKeyValue(entity: .Character, key: "id", value: id)
        }
    }
}
