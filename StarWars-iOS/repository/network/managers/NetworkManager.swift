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
}

class NetworkManager {
    static let shared = NetworkManager()

    private let apiBaseUrl = "https://swapi.py4e.com/api/"

    func getAsyncAwait<T: Decodable>(url: String) async throws -> (Result<T, Error>) {
        let urlString = "\(apiBaseUrl)\(url)"

        guard let url = URL(string: urlString) else {
            return .failure(NetworkError.URLError)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let safeResponse = response as? HTTPURLResponse, safeResponse.statusCode == 200 else {
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
