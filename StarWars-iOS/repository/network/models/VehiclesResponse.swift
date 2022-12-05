//
//  VehiclesResponse.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 5/12/22.
//

import Foundation

struct VehicleResponse: Codable {
    let name, model, manufacturer, length, crew, passengers, consumables: String
    let costInCredits, maxAtmospheringSpeed, cargoCapacity, vehicleClass: String
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer, length, crew, passengers, consumables
        case costInCredits = "cost_in_credits"
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case cargoCapacity = "cargo_capacity"
        case vehicleClass = "vehicle_class"
        case created, edited, url
    }
}
