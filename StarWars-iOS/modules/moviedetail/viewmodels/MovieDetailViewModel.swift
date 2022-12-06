//
//  MovieDetailViewModel.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation
import SVProgressHUD

class MovieDetailViewModel: ViewModel {
    weak var coordinator: AppCoordinator!

    let manager: DetailProtocolManager
    let movie: Movie

    init(movie: Movie, manager: DetailProtocolManager) {
        self.movie = movie
        self.manager = manager
    }

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

    var shipsList: [Starship] = [] {
        didSet {
            reloadData?()
        }
    }

    func getCharacters() {
        SVProgressHUD.show()
        Task.init {
            let characterResult = await manager.getCharactersByMovieAsync(idMovie: movie.id)
            switch characterResult {
            case .success(let characters):
                self.charactersList = characters
                onFinish?()
            case .failure(let failure):
                onError?(failure)
            }
        }
    }

    func getPlanets() {
        SVProgressHUD.show()
        Task.init {
            let planetResult = await manager.getPlanetsByMovieAsync(idMovie: movie.id)
            switch planetResult {
            case .success(let planets):
                self.planetsList = planets
                onFinish?()
            case .failure(let failure):
                onError?(failure)
            }
        }
    }

    func getSpecies() {
        SVProgressHUD.show()
        Task.init {
            let specieResult = await manager.getSpeciesByMovieAsync(idMovie: movie.id)
            switch specieResult {
            case .success(let species):
                self.speciesList = species
                onFinish?()
            case .failure(let failure):
                onError?(failure)
            }
        }
    }

    func getStarships() {
        SVProgressHUD.show()
        Task.init {
            let shipResult = await manager.getStarshipsByMovieAsync(idMovie: movie.id)
            switch shipResult {
            case .success(let ships):
                self.shipsList = ships
                onFinish?()
            case .failure(let failure):
                onError?(failure)
            }
        }
    }
}
