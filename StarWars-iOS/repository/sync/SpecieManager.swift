//
//  SpecieManager.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 2/12/22.
//

import Foundation

class SpecieManager {
    static let shared = SpecieManager()
    func getSpeciesByMovieAsync(movie: Movie) async throws -> [Specie] {
        do {
            let specIds = MovieManagerLocal.getIdsFromString(stringIds: movie.speciesIds)
            let species = try await SpecieManagerNetwork.shared.getAllSpeciesByMovieAsync(speciesIdsList: specIds)
            SpecieManagerLocal.shared.deleteSpeciesByMovie(movie: movie)
            SpecieManagerLocal.shared.saveAllSpeciesByMovie(speciesList: species, movie: movie)
            return movie.speciesArray
        } catch let error {
            let species = movie.speciesArray
            if species.isEmpty {
                throw error
            } else {
                return species
            }
        }
    }
}
