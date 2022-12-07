//
//  VehicleViewController.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 5/12/22.
//

import UIKit
import SVProgressHUD

class VehicleViewController: UIViewController {

    @IBOutlet weak var vehiclesTableView: UITableView!
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
        viewModel.getVehicles()
    }

    func setupView() {
        let nibChar = UINib(nibName: VehicleTableViewCell.nibName, bundle: nil)
        vehiclesTableView.register(nibChar, forCellReuseIdentifier: VehicleTableViewCell.identifier)
        vehiclesTableView.delegate = self
        vehiclesTableView.dataSource = self
        vehiclesTableView.estimatedRowHeight = 80

        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)

        vehiclesTableView.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
        SVProgressHUD.show()
        viewModel.getVehicles()
    }

    private func initViewModel() {
        viewModel.reloadData = { [weak self] in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self?.vehiclesTableView.reloadData()
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

extension VehicleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.vehiclesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = vehiclesTableView.dequeueReusableCell(withIdentifier: VehicleTableViewCell.identifier)
        as? VehicleTableViewCell ?? VehicleTableViewCell()
        cell.selectionStyle = .none

        let vehicle = viewModel.vehiclesList[indexPath.row]
        cell.setData(vehicle: vehicle)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
