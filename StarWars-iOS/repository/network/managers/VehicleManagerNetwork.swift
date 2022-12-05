//
//  VehicleManagerNetwork.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 5/12/22.
//

import Foundation

class VehicleManagerNetwork {
    static let shared = VehicleManagerNetwork()
    let baseUrl = "https://swapi.dev/api/vehicles"

    func getAllVehicleByMovie(completion: @escaping (Result<VehicleResponse, Error>) -> Void) {
        guard let targetUrl = URL(string: baseUrl) else {return}
        NetworkManager.shared.get(VehicleResponse.self, from: targetUrl) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getVehicleAsync(vehicleUrl: String) async throws -> VehicleResponse {
        do {
            guard let targetUrl = URL(string: vehicleUrl) else { throw NetworkError.networkError}
            let vehicle = try await NetworkManager.shared.getAsync(VehicleResponse.self, from: targetUrl)
            return vehicle
        } catch let error {
            throw error
        }
    }

    func getAllVehiclesByMovieAsync(vehiclesIdsList: [String]) async throws -> [VehicleResponse] {
        do {
            var finalVehiclesList = [VehicleResponse]()
            for id in vehiclesIdsList {
                let url = "\(self.baseUrl)/\(id)"
                let vehicle = try await getVehicleAsync(vehicleUrl: url)
                finalVehiclesList.append(vehicle)
            }
            return finalVehiclesList
        } catch let error {
            throw error
        }
    }
}
