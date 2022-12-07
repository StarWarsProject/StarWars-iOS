//
//  SpecieResponse.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 2/12/22.
//

import Foundation
import CoreData

struct SpecieResponse: Codable {
    let name, classification, designation, language: String
    let averageHeight, skinColors, hairColors, eyeColors, averageLifespan: String
    let created, edited: String
    let url: String
    let homeworld: String?

    enum CodingKeys: String, CodingKey {
        case name, classification, designation, homeworld, language
        case averageHeight = "average_height"
        case skinColors = "skin_colors"
        case hairColors = "hair_colors"
        case eyeColors = "eye_colors"
        case averageLifespan = "average_lifespan"
        case created, edited, url
    }

    func toEntity(context: NSManagedObjectContext) -> Specie {
        let newSpecie = Specie(context: CoreDataManager.shared.getContext())
        newSpecie.name = name
        newSpecie.createdAt = Date()
        newSpecie.desc = ""
        newSpecie.classification = classification
        newSpecie.language = language
        newSpecie.planet = ""
        var idSpe = url
        idSpe.removeLast()
        newSpecie.id = Int16(String(idSpe[(idSpe.index(after: idSpe.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idSpe)))...])) ?? 0
        newSpecie.image = ""
        newSpecie.updatedAt = Date()
        return newSpecie
    }
}
