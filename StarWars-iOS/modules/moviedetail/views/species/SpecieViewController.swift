//
//  SpecieViewController.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 2/12/22.
//

import UIKit

class SpecieViewController: UIViewController {

    @IBOutlet weak var speciesTableView: UITableView!

    var viewModel: MovieDetailViewModel

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initViewModel()
        // viewModel.getSpecies()
    }

    func setupView() {
        let nibChar = UINib(nibName: SpecieTableViewCell.nibName, bundle: nil)
        speciesTableView.register(nibChar, forCellReuseIdentifier: SpecieTableViewCell.identifier)
        speciesTableView.delegate = self
        speciesTableView.dataSource = self
        speciesTableView.estimatedRowHeight = 80
    }

    private func initViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.speciesTableView.reloadData()
            }
        }

        viewModel.onError = { error in
            print(error)
        }
    }
}

extension SpecieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.speciesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = speciesTableView.dequeueReusableCell(withIdentifier: SpecieTableViewCell.identifier)
        as? SpecieTableViewCell ?? SpecieTableViewCell()
        cell.selectionStyle = .none

        let specie = viewModel.speciesList[indexPath.row]
        cell.setData(specie: specie)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
