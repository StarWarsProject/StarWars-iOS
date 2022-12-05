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

    var manager: DetailProtocolManager = DetaiManager.shared

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
    var movie: Movie
    init(movie: Movie) {
        // constructor
        self.movie = movie
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
}
