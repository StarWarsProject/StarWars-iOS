//
//  MovieManagerLocal.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation

class MovieManagerLocal {
    static let shared = MovieManagerLocal()
    static func getStringFromIds(idList: [String]) -> String {
        return idList.joined(separator: "-")
    }

    static func getIdsFromString(stringIds: String) -> [String] {
        return stringIds.components(separatedBy: "-")
    }

    func saveMovies(films: [Film]) {
        films.forEach { film in
            film.toEntity(context: CoreDataManager.shared.getContext())
            CoreDataManager.shared.saveContext()
        }
    }

    func getMovies() -> [Movie] {
        let results: [Movie] = CoreDataManager.shared.getData(entity: .Movie)
        return results
    }
}
