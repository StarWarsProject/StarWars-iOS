//
//  AppCoordinator.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 30/11/22.
//

import Foundation
import UIKit

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
        let homeViewController = HomeViewController()
        let homeViewModel = HomeViewModel.init()
        homeViewModel.coordinator = self
        homeViewController.viewModel = homeViewModel
        navigationController.pushViewController(homeViewController, animated: true)
    }

    func goToDetailsScreen(movie: Movie) {
        let movieDetailsViewController = MovieDetailViewController(movie: movie)
        let movieDetailsViewModel = MovieDetailViewModel.init(movie: movie)
        movieDetailsViewModel.coordinator = self
        movieDetailsViewController.viewModel = movieDetailsViewModel
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
