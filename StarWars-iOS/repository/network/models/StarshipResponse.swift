//
//  StarshipResponse.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 5/12/22.
//

import Foundation
import CoreData

struct StarshipsResponse: Codable {
    let name, model, manufacturer, costInCredits: String
    let length, maxAtmospheringSpeed, crew, passengers: String
    let cargoCapacity, consumables, hyperdriveRating, mglt: String
    let starshipClass: String
    let pilots: [String]
    let films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew, passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        case mglt = "MGLT"
        case starshipClass = "starship_class"
        case pilots, films, created, edited, url
    }

    func toEntity(context: NSManagedObjectContext) -> Starship {
        let newShip = Starship(context: context)
        newShip.name = name
        newShip.model = model
        newShip.manufacturer = manufacturer
        newShip.length = length
        newShip.maxAtmospheringSpeed = maxAtmospheringSpeed
        newShip.crew = crew
        newShip.passengers = passengers
        newShip.cargoCapacity = cargoCapacity
        newShip.starshipClass = starshipClass
        newShip.createdAt = Date()
        var idShip = url
        idShip.removeLast()
        newShip.id = Int16(String(idShip[(idShip.index(after: idShip.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idShip)))...])) ?? 0
        newShip.updatedAt = Date()
        return newShip
    }
}
