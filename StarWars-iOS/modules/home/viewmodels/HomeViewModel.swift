//
//  HomeViewModel.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 11/22/22.
//

import Foundation

class HomeViewModel: ViewModel {

    var onSelectedMovie: ((Movie) -> Void)?

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

    func callMovieList() {
        // MARK: Regular way
//        MovieManager.shared.getAllMovies { result in
//            switch result {
//            case .success(let movies):
//                movies.forEach { movie in
//                    print(movie.title)
//                }
//                print(movies.count)
//            case .failure(let error):
//                print(error.localizedDescription)
//                print("no data, no internet")
//            }
//        }

        // MARK: Async way
        Task.init {
            do {
                let movies = try await MovieManager.shared.getAllMoviesAsync()
                onFinish?()
                movieList = movies
            } catch let error {
                onError?(error.localizedDescription)
            }
        }
    }
}
