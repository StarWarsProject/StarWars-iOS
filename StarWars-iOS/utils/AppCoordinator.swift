//
//  AppCoordinator.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 30/11/22.
//

import Foundation
import UIKit
import SVProgressHUD

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        goToHomeScreen()
    }

    func goToHomeScreen() {
        let homeViewModel = HomeViewModel.init()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        homeViewModel.coordinator = self
        homeViewModel.reloadData = {
            DispatchQueue.main.async {
                homeViewController.filmsCollectionView.reloadData()
            }
        }

        homeViewModel.onSelectedMovie = { movie in
            homeViewController.setSelectedMovieDetails(movie: movie)
        }

        homeViewModel.onFinish = {
            homeViewController.hideErrorView()
            homeViewModel.selectedMovie = homeViewController.viewModel.getMovieAtIndex(0)
            DispatchQueue.main.sync {
                homeViewController.filmsCollectionView.reloadData()
            }
            SVProgressHUD.dismiss()
        }
        homeViewModel.onError = { error in
            SVProgressHUD.dismiss()
            homeViewController.setLabelForError(error: error.localizedDescription)
        }
        navigationController.pushViewController(homeViewController, animated: true)
    }

    func goToDetailsScreen(movie: Movie) {
        let movieDetailsViewModel = MovieDetailViewModel.init(movie: movie)
        let movieDetailsViewController = MovieDetailViewController(viewModel: movieDetailsViewModel)
        movieDetailsViewModel.coordinator = self
        movieDetailsViewModel.reloadData = {
            print(movieDetailsViewModel.charactersList.count)
            DispatchQueue.main.async {
                movieDetailsViewController.charactersTableView.reloadData()
            }
        }
        movieDetailsViewModel.onFinish = {
            SVProgressHUD.dismiss()
        }
        movieDetailsViewModel.onError = { error in
            print(error)
        }
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
