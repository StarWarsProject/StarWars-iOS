//
//  ShipViewController.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 5/12/22.
//

import UIKit

class ShipViewController: UIViewController {

    @IBOutlet weak var shipsTableView: UITableView!

    let viewModel: MovieDetailViewModel

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
        Task.init {
            await viewModel.getStarships()
        }
    }

    private func setupView() {
        let nib = UINib(nibName: ShipTableViewCell.nibName, bundle: nil)
        shipsTableView.register(nib, forCellReuseIdentifier: ShipTableViewCell.identifier)
        shipsTableView.delegate = self
        shipsTableView.dataSource = self
        shipsTableView.estimatedRowHeight = 80
    }

    private func initViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.shipsTableView.reloadData()
            }
        }

        viewModel.onError = { error in
            print(error)
        }
    }
}

extension ShipViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.shipsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shipsTableView.dequeueReusableCell(withIdentifier: ShipTableViewCell.identifier)
        as? ShipTableViewCell ?? ShipTableViewCell()
        cell.selectionStyle = .none

        let ship = viewModel.shipsList[indexPath.row]
        cell.setData(ship: ship)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
