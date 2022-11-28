//
//  MovieDetailViewController.swift
//  StarWars-iOS
//
//  Created by User on 28/11/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieOpeningLabel: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDirectorLabel: UILabel!
    @IBOutlet weak var movieProducerLabel: UILabel!
    @IBOutlet weak var tabsCollectionView: UICollectionView!

    var movieDetail = Movie()
    let tabsList = ["Personajes", "Planetas", "Especies", "Naves", "Vehiculos"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         let blurEffect = UIBlurEffect(style: .regular)
         let blurEffectView = UIVisualEffectView(effect: blurEffect)
         blurEffectView.frame = imageBackground.bounds
         blurEffectView.alpha = 0.5
         imageBackground.addSubview(blurEffectView)
    }

    private func setupView() {
        // guard movieDetail.self != nil else { return }
        imageBackground.image = getImageForMovie(movieDetail.title)
        movieNameLabel.text = movieDetail.title
        movieOpeningLabel.text = movieDetail.openingCrawl
        // movieReleaseDateLabel.text = movieDetail.releaseDate.getLocalString()
        movieDirectorLabel.text = movieDetail.director
        movieProducerLabel.text = movieDetail.producer

        let nib = UINib(nibName: TabCollectionViewCell.nibName, bundle: nil)
        tabsCollectionView.register(nib, forCellWithReuseIdentifier: TabCollectionViewCell.identifier)
        tabsCollectionView.dataSource = self
        tabsCollectionView.delegate = self
    }

    private func getImageForMovie(_ movieTitle: String) -> UIImage? {
        switch movieTitle {
        case "A New Hope":
            return UIImage(named: StringConstants.newHope)
        case "The Empire Strikes Back":
            return UIImage(named: StringConstants.empireBack)
        case "Return of the Jedi":
            return UIImage(named: StringConstants.returnJedi)
        case "The Phantom Menace":
            return UIImage(named: StringConstants.phantomMenace)
        case "Attack of the Clones":
            return UIImage(named: StringConstants.attackClones)
        case "Revenge of the Sith":
            return UIImage(named: StringConstants.revengeSith)
        default:
            return nil
        }
    }

}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tabsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tab = tabsList[indexPath.row]
        let identifier = TabCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? TabCollectionViewCell
        guard let tabCell = cell else { return UICollectionViewCell() }
        tabCell.setValues(tab: tab)
        return tabCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TabCollectionViewCell {
            cell.descriptionLabel.textColor = UIColor(named: "openingCrawlTextColor")
            cell.lineTabView.isHidden = false
            cell.lineTabView.backgroundColor = UIColor(named: "openingCrawlTextColor")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.5
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
