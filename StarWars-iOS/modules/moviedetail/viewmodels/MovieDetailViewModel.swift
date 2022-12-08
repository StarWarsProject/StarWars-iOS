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

    var manager: DetailManagerProtocol
    let movie: Movie

    init(movie: Movie, manager: DetailManagerProtocol) {
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
    var vehiclesList: [Vehicle] = [] {
        didSet {
            reloadData?()
        }
    }

    var shipsList: [Starship] = [] {
        didSet {
            reloadData?()
        }
    }

    func getCharacters() async {
        await SVProgressHUD.show()
        let characterResult = await manager.getCharactersByMovieAsync(idMovie: movie.id)
        switch characterResult {
        case .success(let characters):
            self.charactersList = characters
            onFinish?()
        case .failure(let failure):
            onError?(failure)
        }
    }

    func getPlanets() async {
        await SVProgressHUD.show()
        let planetResult = await manager.getPlanetsByMovieAsync(idMovie: movie.id)
        switch planetResult {
        case .success(let planets):
            self.planetsList = planets
            onFinish?()
        case .failure(let failure):
            onError?(failure)
        }
    }

    func getSpecies() async {
        await SVProgressHUD.show()
        let specieResult = await manager.getSpeciesByMovieAsync(idMovie: movie.id)
        switch specieResult {
        case .success(let species):
            self.speciesList = species
            onFinish?()
        case .failure(let failure):
            onError?(failure)
        }
    }

    func getStarships() async {
        await SVProgressHUD.show()
        let shipResult = await manager.getStarshipsByMovieAsync(idMovie: movie.id)
        switch shipResult {
        case .success(let ships):
            self.shipsList = ships
            onFinish?()
        case .failure(let failure):
            onError?(failure)
        }
    }

    func getVehicles() async {
        await SVProgressHUD.show()
        let vehicleResult = await manager.getVehiclesByMovieAsync(idMovie: movie.id)
        switch vehicleResult {
        case .success(let vehicles):
            self.vehiclesList = vehicles
            onFinish?()
        case .failure(let failure):
            onError?(failure)
        }
    }
}
