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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        films.forEach { film in
            let newMovie = Movie(context: CoreDataManager.shared.getContext())
            var idFilm = film.url
            idFilm.removeLast()
            newMovie.id = Int16(String(idFilm.last ?? "0")) ?? 0
            newMovie.title = film.title
            newMovie.director = film.director
            newMovie.producer = film.producer
            newMovie.openingCrawl = film.openingCrawl
            newMovie.episodeId = Int16(film.episodeID)
            let charactersIds = film.characters.map { char in
                var charUrl = char
                charUrl.removeLast()
                return String(charUrl[(charUrl.index(after: charUrl.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: charUrl)))...])
            }
            let planetsIds = film.planets.map { plan in
                var platUrl = plan
                platUrl.removeLast()
                return String(platUrl[(platUrl.index(after: platUrl.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: platUrl)))...])
            }
            let speciesIds = film.species.map { spe in
                var specUrl = spe
                specUrl.removeLast()
                return String(specUrl[(specUrl.index(after: specUrl.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: specUrl)))...])
            }
            let vehiclesIds = film.vehicles.map { veh in
                var vehiUrl = veh
                vehiUrl.removeLast()
                return String(vehiUrl[(vehiUrl.index(after: vehiUrl.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: vehiUrl)))...])
            }
            let starshipsIds = film.starships.map { char in
                var specUrl = char
                specUrl.removeLast()
                return String(specUrl[(specUrl.index(after: specUrl.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: specUrl)))...])
            }
            newMovie.charactersIds = MovieManagerLocal.getStringFromIds(idList: charactersIds)
            newMovie.planetsIds = MovieManagerLocal.getStringFromIds(idList: planetsIds)
            newMovie.speciesIds = MovieManagerLocal.getStringFromIds(idList: speciesIds)
            newMovie.starshipsIds = MovieManagerLocal.getStringFromIds(idList: starshipsIds)
            newMovie.vehiclesIds = MovieManagerLocal.getStringFromIds(idList: vehiclesIds)
            newMovie.releaseDate = dateFormatter.date(from: film.releaseDate) ?? Date()
            newMovie.createdAt = Date()
            newMovie.updatedAt = Date()
            CoreDataManager.shared.saveContext()
        }
    }

    func getMovies() -> [Movie] {
        let results: [Movie] = CoreDataManager.shared.getData(entity: .Movie)
        return results
    }
}
