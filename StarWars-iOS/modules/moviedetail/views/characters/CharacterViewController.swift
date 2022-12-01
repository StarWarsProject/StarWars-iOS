//
//  CharacterViewController.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 30/11/22.
//

import UIKit

class CharacterViewController: UIViewController {
    @IBOutlet weak var charactersTableView: UITableView!

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
        viewModel.getCharacters()
    }

    func setupView() {
        let nibChar = UINib(nibName: CharacterTableViewCell.nibName, bundle: nil)
        charactersTableView.register(nibChar, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.estimatedRowHeight = 80
    }

    private func initViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.charactersTableView.reloadData()
            }
        }

        viewModel.onError = { error in
            print(error)
        }
    }

}

extension CharacterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.charactersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier)
        as? CharacterTableViewCell ?? CharacterTableViewCell()
        cell.selectionStyle = .none

        let character = viewModel.charactersList[indexPath.row]
        cell.setData(character: character)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
