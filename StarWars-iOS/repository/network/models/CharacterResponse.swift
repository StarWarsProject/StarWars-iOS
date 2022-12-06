//
//  Character.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation
import CoreData

struct CharacterResponse: Codable, ModelResponseProtocol {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear, gender: String
    let homeworld: String
    let films, species, vehicles, starships: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }

    func toEntity(context: NSManagedObjectContext) -> NSManagedObject {
        let newCharacter = Character(context: context)
        newCharacter.name = name
        newCharacter.birth = birthYear
        newCharacter.createdAt = Date()
        newCharacter.desc = ""
        newCharacter.gender = gender
        newCharacter.height = height
        var idChar = url
        idChar.removeLast()
        newCharacter.id = Int16(String(idChar[(idChar.index(after: idChar.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idChar)))...])) ?? 0
        newCharacter.image = ""
        newCharacter.planet = ""
        newCharacter.specie = ""
        newCharacter.updatedAt = Date()
        return newCharacter
    }

}
