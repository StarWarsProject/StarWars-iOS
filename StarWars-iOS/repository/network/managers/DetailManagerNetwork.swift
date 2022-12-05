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

class DetailManagerNetwork {
    static let shared = DetailManagerNetwork()
    private let networkManager = NetworkManager.shared

    private func getDataByIdAsync<T: Decodable>(url: String) async -> Result<T, Error> {
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
                return .failure(failure)
            }
        }
        return .success(finalCharactersList)
    }
}
