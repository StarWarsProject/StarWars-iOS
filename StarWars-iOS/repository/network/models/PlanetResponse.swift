//
//  PlanetResponse.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 30/11/22.
//

import Foundation
import CoreData

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

    func toEntity(context: NSManagedObjectContext) -> Planet {
        let newPlanet = Planet(context: context)
        newPlanet.name = name
        newPlanet.createdAt = Date()
        newPlanet.desc = ""
        newPlanet.region = ""
        newPlanet.system = ""
        newPlanet.climate = climate
        newPlanet.terrain = terrain
        newPlanet.population = population
        var idPlan = url
        idPlan.removeLast()
        newPlanet.id = Int16(String(idPlan[(idPlan.index(after: idPlan.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idPlan)))...])) ?? 0
        newPlanet.image = ""
        newPlanet.updatedAt = Date()
        return newPlanet
    }
}
