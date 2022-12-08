//
//  VehiclesResponse.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 5/12/22.
//

import Foundation
import CoreData

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

    func toEntity(context: NSManagedObjectContext) -> Vehicle {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newVehicle = Vehicle(context: context)
        newVehicle.name = name
        newVehicle.createdAt = Date()
        newVehicle.cargoCapacity = cargoCapacity
        newVehicle.crew = crew
        newVehicle.length = length
        newVehicle.manufacturer = manufacturer
        newVehicle.maxAtmospheringSpeed = maxAtmospheringSpeed
        newVehicle.model = model
        newVehicle.passengers = passengers
        newVehicle.vehicleClass = vehicleClass
        var idVeh = url
        idVeh.removeLast()
        newVehicle.id = Int16(String(idVeh[(idVeh.index(after: idVeh.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idVeh)))...])) ?? 0
        newVehicle.updatedAt = Date()
        return newVehicle
    }
}
