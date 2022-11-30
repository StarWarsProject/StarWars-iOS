//
//  PlanetViewController.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 30/11/22.
//

import UIKit

class PlanetViewController: UIViewController {

    @IBOutlet weak var planetsTableView: UITableView!

    var viewModel = MovieDetailViewModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initViewModel()
        viewModel.getPlanets()
    }

    func setupView() {
        let nibChar = UINib(nibName: PlanetTableViewCell.nibName, bundle: nil)
        planetsTableView.register(nibChar, forCellReuseIdentifier: PlanetTableViewCell.identifier)
        planetsTableView.delegate = self
        planetsTableView.dataSource = self
        planetsTableView.estimatedRowHeight = 80
    }

    private func initViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.planetsTableView.reloadData()
            }
        }

        viewModel.onError = { error in
            print(error)
        }
    }
}

extension PlanetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.planetsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = planetsTableView.dequeueReusableCell(withIdentifier: PlanetTableViewCell.identifier)
        as? PlanetTableViewCell ?? PlanetTableViewCell()
        cell.selectionStyle = .none

        let planet = viewModel.planetsList[indexPath.row]
        cell.setData(planet: planet)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
