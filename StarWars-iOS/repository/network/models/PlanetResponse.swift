//
//  PlanetResponse.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 30/11/22.
//

import Foundation

struct PlanetResponse: Codable {
    let name, diameter, climate, gravity, terrain, population: String
    let rotationPeriod, orbitalPeriod, surfaceWater: String
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, diameter, climate, gravity, terrain, population
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case surfaceWater = "surface_water"
        case created, edited, url
    }
}