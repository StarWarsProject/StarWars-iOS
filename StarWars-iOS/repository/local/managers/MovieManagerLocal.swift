//
//  MovieManagerLocal.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation

class MovieManagerLocal {
    static let shared = MovieManagerLocal()

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
