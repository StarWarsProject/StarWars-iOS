//
//  PlanetViewController.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 30/11/22.
//

import UIKit
import SVProgressHUD

class PlanetViewController: UIViewController {

    @IBOutlet weak var planetsTableView: UITableView!
    private let refreshControl = UIRefreshControl()
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
        initViewModel()
        setupView()
        Task.init {
            await viewModel.getPlanets()
        }
    }

    func setupView() {
        let nibChar = UINib(nibName: PlanetTableViewCell.nibName, bundle: nil)
        planetsTableView.register(nibChar, forCellReuseIdentifier: PlanetTableViewCell.identifier)
        planetsTableView.delegate = self
        planetsTableView.dataSource = self
        planetsTableView.estimatedRowHeight = 80

        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)

        planetsTableView.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
        SVProgressHUD.show()
        Task.init {
            await viewModel.getPlanets()
        }
    }

    private func initViewModel() {
        viewModel.reloadData = { [weak self] in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self?.planetsTableView.reloadData()
            }
        }
        viewModel.onFinish = {
            SVProgressHUD.dismiss()
            DispatchQueue.main.sync {
                self.refreshControl.endRefreshing()
            }
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
