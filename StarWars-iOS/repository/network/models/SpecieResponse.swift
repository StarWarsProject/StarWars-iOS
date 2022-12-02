//
//  SpecieResponse.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 2/12/22.
//

import Foundation

struct SpecieResponse: Codable {
    let name, classification, designation, homeworld, language: String
    let skinColors, hairColors, eyeColors, averageLifespan: String
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, classification, designation, homeworld, language
        case skinColors = "skin_colors"
        case hairColors = "hair_colors"
        case eyeColors = "eye_colors"
        case averageLifespan = "average_lifespan"
        case created, edited, url
    }
}
