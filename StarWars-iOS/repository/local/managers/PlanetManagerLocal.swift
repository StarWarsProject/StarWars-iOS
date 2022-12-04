//
//  PlanetManagerLocal.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 30/11/22.
//

import Foundation

class PlanetManagerLocal {
    static let shared = PlanetManagerLocal()

    func saveAllPlanetsByMovie(planetsList: [PlanetResponse], movie: Movie) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Save Planets
        planetsList.forEach { planet in
            let newPlanet = Planet(context: CoreDataManager.shared.getContext())
            newPlanet.name = planet.name
            newPlanet.createdAt = Date()
            newPlanet.desc = ""
            newPlanet.region = ""
            newPlanet.system = ""
            newPlanet.climate = planet.climate
            newPlanet.terrain = planet.terrain
            newPlanet.population = planet.population
            var idPlan = planet.url
            idPlan.removeLast()
            newPlanet.id = Int16(String(idPlan[(idPlan.index(after: idPlan.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idPlan)))...])) ?? 0
            newPlanet.image = ""
            newPlanet.updatedAt = Date()
            newPlanet.addToMovies(movie)
            CoreDataManager.shared.saveContext()
        }
    }

    func deletePlanetsByMovie(movie: Movie) {
        let charsIds = MovieManagerLocal.getIdsFromString(stringIds: movie.planetsIds)
        charsIds.forEach { id in
            CoreDataManager.shared.deleteEntityObjectByKeyValue(entity: .Planet, key: "id", value: id)
        }
    }
}
