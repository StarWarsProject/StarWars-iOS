//
//  VehicleManager.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 5/12/22.
//

import Foundation

class VehicleManager {
    static let shared = VehicleManager()
    func getVehiclesByMovieAsync(movie: Movie) async throws -> [Vehicle] {
        do {
            let vehIds = MovieManagerLocal.getIdsFromString(stringIds: movie.vehiclesIds)
            let vehicles = try await VehicleManagerNetwork.shared.getAllVehiclesByMovieAsync(vehiclesIdsList: vehIds)
            VehicleManagerLocal.shared.deleteVehiclesByMovie(movie: movie)
            VehicleManagerLocal.shared.saveAllVehiclesByMovie(vehiclesList: vehicles, movie: movie)
            return movie.vehiclesArray
        } catch let error {
            let vehicles = movie.vehiclesArray
            if vehicles.isEmpty {
                throw error
            } else {
                return vehicles
            }
        }
    }
}
