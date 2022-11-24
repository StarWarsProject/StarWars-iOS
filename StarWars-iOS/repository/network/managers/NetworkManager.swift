//
//  NetworkManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation

enum NetworkError: Error {
    case networkError
}

class NetworkManager {
    static let shared = NetworkManager(session: URLSession.shared)
    let session: URLSession
    init(session: URLSession) {
        self.session = session
    }

    @discardableResult
    func get<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.sync {
                    completion(.failure(error))
                }
                return
            }
            let jsonDecoder = JSONDecoder()
            if let data = data, let items = try? jsonDecoder.decode(type, from: data) {
                DispatchQueue.main.sync {
                    completion(.success(items))
                }
            } else {
                DispatchQueue.main.sync {
                    completion(.failure(NetworkError.networkError))
                }
            }
        }
        task.resume()
        return task
    }

    func getAsync<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonDecoder = JSONDecoder()
            guard let items = try? jsonDecoder.decode(type, from: data) else { throw NetworkError.networkError }
            return items
        } catch let error {
            print(error)
            throw error
        }
    }
}
