//
//  HomeViewModel.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 11/22/22.
//

import Foundation

enum SortFieldsOptions {
    case ReleaseDate
    case EpisodeCronId
}

enum SortOptions {
    case Ascending
    case Desceding
}

class HomeViewModel: ViewModel {

    weak var coordinator: AppCoordinator!

    var onSelectedMovie: ((Movie) -> Void)?
    var movieIndex = 0
    var selectedMovie: Movie?

    private var originalMovieList: [Movie] = []
    private var movieList: [Movie] = [] {
        didSet {
            reloadData?()
            guard let firstMovie = movieList.first else { return }
            onSelectedMovie?(firstMovie)
        }
    }

    var moviesCount: Int {
        movieList.count
    }

    func getMovieAtIndex(_ index: Int) -> Movie {
        movieList[index]
    }

    func goToDetailsPage() {
        coordinator.goToDetailsScreen(movie: movieList[movieIndex])
    }

    func callMovieList() {
        Task.init {
            do {
                let movies = try await MovieManager.shared.getAllMoviesAsync()
                movieList = movies
                originalMovieList = movies
                onFinish?()
            } catch let error {
                onError?(error.localizedDescription)
            }
        }
    }

    func sortMovies(field: SortFieldsOptions, criteria: SortOptions) {
        switch field {
        case .EpisodeCronId:
            movieList = movieList.sorted(by: {$0.episodeId > $1.episodeId})
        case .ReleaseDate:
            movieList = movieList.sorted(by: {$0.releaseDate > $1.releaseDate})
        }
        if criteria == .Ascending {
            movieList = movieList.reversed()
        }
    }
}
