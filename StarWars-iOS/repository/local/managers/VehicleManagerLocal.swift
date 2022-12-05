//
//  VehicleManagerLocal.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 5/12/22.
//

import Foundation

class VehicleManagerLocal {
    static let shared = VehicleManagerLocal()

    func saveAllVehiclesByMovie(vehiclesList: [VehicleResponse], movie: Movie) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Save Vehicles
        vehiclesList.forEach { vehicle in
            let newVehicle = Vehicle(context: CoreDataManager.shared.getContext())
            newVehicle.name = vehicle.name
            newVehicle.createdAt = Date()
            newVehicle.cargoCapacity = vehicle.cargoCapacity
            newVehicle.crew = vehicle.crew
            newVehicle.length = vehicle.length
            newVehicle.manufacturer = vehicle.manufacturer
            newVehicle.maxAtmospheringSpeed = vehicle.maxAtmospheringSpeed
            newVehicle.model = vehicle.model
            newVehicle.passengers = vehicle.passengers
            newVehicle.vehicleClass = vehicle.vehicleClass
            var idVeh = vehicle.url
            idVeh.removeLast()
            newVehicle.id = Int16(String(idVeh[(idVeh.index(after: idVeh.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idVeh)))...])) ?? 0
            newVehicle.updatedAt = Date()
            newVehicle.addToMovies(movie)
            CoreDataManager.shared.saveContext()
        }
    }

    func deleteVehiclesByMovie(movie: Movie) {
        let vehIds = MovieManagerLocal.getIdsFromString(stringIds: movie.vehiclesIds)
        vehIds.forEach { id in
            CoreDataManager.shared.deleteEntityObjectByKeyValue(entity: .Vehicle, key: "id", value: id)
        }
    }
}
