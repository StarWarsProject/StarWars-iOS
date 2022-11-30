//
//  MovieDetailViewModel.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 28/11/22.
//

import Foundation

class MovieDetailViewModel: ViewModel {
    var charactersList: [Character] = [] {
        didSet {
            reloadData?()
        }
    }

    func getCharacters(charsUrls: [String], movie: Movie) {
        Task.init {
            do {
                self.charactersList = try await CharacterManager.shared.getCharactersByMovieAsync(characterUrlList: charsUrls, movie: movie)
            } catch let error {
                onError?(error.localizedDescription)
            }
        }
    }
}
