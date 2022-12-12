//
//  NetworkManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation

enum NetworkError: Error {
    case NetworkError(msg: String)
    case URLError
    case CantConnectToAPI
    case ServerSideError(code: Int)
    case JSONParsingException
    case NoDataFromAPI
}

protocol NetworkManagerProtocol {
    func getAsyncAwait<T: Decodable>(url: String) async throws -> (Result<T, Error>)
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()

    private let apiBaseUrl = "https://swapi.dev/api"

    func getAsyncAwait<T: Decodable>(url: String) async throws -> (Result<T, Error>) {
        let urlString = "\(apiBaseUrl)\(url)"

        guard let url = URL(string: urlString) else {
            return .failure(NetworkError.URLError)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let safeResponse = response as? HTTPURLResponse else {
            return .failure(NetworkError.CantConnectToAPI)
        }

        guard safeResponse.statusCode != 404 else {
            return .failure(NetworkError.NoDataFromAPI)
        }

        guard safeResponse.statusCode == 200 else {
            return .failure(NetworkError.CantConnectToAPI)
        }

        guard (200...299).contains(safeResponse.statusCode) else {
            return .failure(NetworkError.ServerSideError(code: safeResponse.statusCode))
        }

        do {
            let apiResponse = try JSONDecoder().decode(T.self, from: data)
            return .success(apiResponse)
        } catch {
            return .failure(NetworkError.JSONParsingException)
        }
    }
}
