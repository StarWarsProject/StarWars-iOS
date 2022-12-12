//
//  FileReader.swift
//  StarWars-iOSTests
//
//  Created by Yawar Valeriano on 10/12/22.
//

import Foundation

struct FileReader {

    static func readFrom<T: Decodable>(url: String, as: T.Type, withError: Bool = false) -> T? {
        var name = ""
        switch url {
        case let endpoint where endpoint.contains("/people"):
            name = "people1" + (withError ? "error" : "")
        case let endpoint where endpoint.contains("/planets"):
            name = "planet1" + (withError ? "error" : "")
        case let endpoint where endpoint.contains("/species"):
            name = "species1" + (withError ? "error" : "")
        case let endpoint where endpoint.contains("/starships"):
            name = "starships1" + (withError ? "error" : "")
        case let endpoint where endpoint.contains("/vehicles"):
            name = "vehicles1" + (withError ? "error" : "")
        default:
            return nil
        }
        guard let bundle = Bundle.main.path(forResource: name, ofType: "json") else {
            print("Missing File: \(name).json")
            return nil
        }
        do {
            guard let data = try String(contentsOfFile: bundle).data(using: .utf8) else {
                return nil
            }
            let apiResponse = try JSONDecoder().decode(T.self, from: data)
            return apiResponse
        } catch {
            return nil
        }
    }
}
