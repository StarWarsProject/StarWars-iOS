//
//  SpecieManagerLocal.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 2/12/22.
//

import Foundation

class SpecieManagerLocal {
    static let shared = SpecieManagerLocal()

    func saveAllSpeciesByMovie(speciesList: [SpecieResponse], movie: Movie) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // Save Species
        speciesList.forEach { specie in
            let newSpecie = Specie(context: CoreDataManager.shared.getContext())
            newSpecie.name = specie.name
            newSpecie.createdAt = Date()
            newSpecie.desc = ""
            newSpecie.classification = specie.classification
            newSpecie.language = specie.language
            newSpecie.planet = ""
            var idSpe = specie.url
            idSpe.removeLast()
            newSpecie.id = Int16(String(idSpe[(idSpe.index(after: idSpe.lastIndex(of: "/") ?? String.Index(utf16Offset: 1, in: idSpe)))...])) ?? 0
            newSpecie.image = ""
            newSpecie.updatedAt = Date()
            newSpecie.addToMovies(movie)
            CoreDataManager.shared.saveContext()
        }
    }

    func deleteSpeciesByMovie(movie: Movie) {
        let charsIds = MovieManagerLocal.getIdsFromString(stringIds: movie.speciesIds)
        charsIds.forEach { id in
            CoreDataManager.shared.deleteEntityObjectByKeyValue(entity: .Specie, key: "id", value: id)
        }
    }
}
