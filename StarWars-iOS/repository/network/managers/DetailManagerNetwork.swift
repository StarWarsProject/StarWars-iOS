//
//  CharacterManagerNetwork.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation

enum DetailEndpointURL: String {
    case people = "/people"
    case planets = "/planets"
    case species = "/species"
    case starships = "/starships"
    case vehicles = "/vehicles"
}

protocol DetailManagerNetworkProtocol {
    func getDataByIdAsync<T: Decodable>(url: String) async -> Result<T, Error>
    func getAllDataForTabIdAsync<T: Decodable>(idList: [String], forTab: DetailEndpointURL) async -> Result<[T], Error>
}

class DetailManagerNetwork: DetailManagerNetworkProtocol {
    static let shared = DetailManagerNetwork()
    var networkManager: NetworkManagerProtocol = NetworkManager.shared

    internal func getDataByIdAsync<T: Decodable>(url: String) async -> Result<T, Error> {
        do {
            return try await networkManager.getAsyncAwait(url: url)
        } catch {
            return .failure(NetworkError.NetworkError(msg: error.localizedDescription))
        }
    }

    func getAllDataForTabIdAsync<T: Decodable>(idList: [String], forTab: DetailEndpointURL) async -> Result<[T], Error> {
        var finalCharactersList = [T]()
        for id in idList {
            let url = "\(forTab.rawValue)/\(id)"
            let result: Result<T, Error> = await getDataByIdAsync(url: url)
            switch result {
            case .success(let data):
                finalCharactersList.append(data)
            case .failure(let failure):
                if let error = failure as? NetworkError {
                    switch error {
                    case .NoDataFromAPI:
                        continue
                    default:
                        return.failure(error)
                    }
                }
                return .failure(failure)
            }
        }
        return .success(finalCharactersList)
    }
}
