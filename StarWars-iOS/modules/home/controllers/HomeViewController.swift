//
//  HomeViewController.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 11/22/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var labelText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        labelText.text = NSLocalizedString("title", comment: "")
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
                movies.forEach { movie in
                    print(movie.title)
                }
                print(movies.count)
            } catch let error {
                print(error.localizedDescription)
                print("no data, no internet")
            }
        }
    }
}
