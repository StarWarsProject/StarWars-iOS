//
//  MovieDetailViewModel.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation

class MovieDetailViewModel: ViewModel {
    static let shared = MovieDetailViewModel()
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
    var movie = Movie()
    /*init(movie: Movie) {
        self.movie = movie
    }*/

    func getCharacters() {
        Task.init {
            do {
                self.charactersList = try await CharacterManager.shared.getCharactersByMovieAsync(movie: movie)
            } catch let error {
                onError?(error.localizedDescription)
            }
        }
    }
}
