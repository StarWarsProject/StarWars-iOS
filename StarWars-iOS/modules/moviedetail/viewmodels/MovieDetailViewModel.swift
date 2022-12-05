//
//  MovieDetailViewModel.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation

class MovieDetailViewModel: ViewModel {
    weak var coordinator: AppCoordinator!
    var charactersList: [Character] = [] {
        didSet {
            reloadData?()
        }
    }
    var planetsList: [Planet] = [] {
        didSet {
            reloadData?()
        }
    }
    var speciesList: [Specie] = [] {
        didSet {
            reloadData?()
        }
    }
    var movie: Movie
    init(movie: Movie) {
        self.movie = movie
    }

    func getCharacters() {
        Task.init {
            do {
                self.charactersList = try await CharacterManager.shared.getCharactersByMovieAsync(movie: movie)
            } catch let error {
                onError?(error.localizedDescription)
            }
        }
    }

    func getPlanets() {
        Task.init {
            do {
                self.planetsList = try await PlanetManager.shared.getPlanetsByMovieAsync(movie: movie)
            } catch let error {
                onError?(error.localizedDescription)
            }
        }
    }

    func getSpecies() {
        Task.init {
            do {
                self.speciesList = try await SpecieManager.shared.getSpeciesByMovieAsync(movie: movie)
            } catch let error {
                onError?(error.localizedDescription)
            }
        }
    }
}
