//
//  SpecieViewController.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 2/12/22.
//

import UIKit
import SVProgressHUD

class SpecieViewController: UIViewController {

    @IBOutlet weak var speciesTableView: UITableView!
    private let refreshControl = UIRefreshControl()
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
        initViewModel()
        setupView()
        viewModel.getSpecies()
    }

    private func setupView() {
        let nibChar = UINib(nibName: SpecieTableViewCell.nibName, bundle: nil)
        speciesTableView.register(nibChar, forCellReuseIdentifier: SpecieTableViewCell.identifier)
        speciesTableView.delegate = self
        speciesTableView.dataSource = self
        speciesTableView.estimatedRowHeight = 80

        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)

        speciesTableView.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
        SVProgressHUD.show()
        viewModel.getSpecies()
    }

    private func initViewModel() {
        viewModel.reloadData = { [weak self] in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self?.speciesTableView.reloadData()
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
