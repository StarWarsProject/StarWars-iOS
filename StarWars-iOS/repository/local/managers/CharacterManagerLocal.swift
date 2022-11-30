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
        charactersList.forEach { character in
            let newCharacter = Character(context: CoreDataManager.shared.getContext())
            var idChar = character.url
            idChar.removeLast()
            newCharacter.name = character.name
            newCharacter.birth = character.birthYear
            newCharacter.createdAt = Date()
            newCharacter.desc = ""
            newCharacter.gender = character.gender
            newCharacter.height = character.height
            newCharacter.id = Int16(String(idChar.last ?? "0")) ?? 0
            newCharacter.image = ""
            newCharacter.planet = ""
            newCharacter.specie = ""
            newCharacter.updatedAt = Date()
            newCharacter.addToMovies(movie)
            CoreDataManager.shared.saveContext()
        }
    }
}
