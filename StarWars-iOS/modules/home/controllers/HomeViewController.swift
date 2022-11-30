//
//  HomeViewController.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 11/22/22.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var movieViewBackground: UIView!
    @IBOutlet weak var selMovieTitleLabel: UILabel!
    @IBOutlet weak var selMovieImage: UIImageView!
    @IBOutlet weak var selMovieCrawlLabel: UILabel!
    @IBOutlet weak var filmsLabel: UILabel!
    @IBOutlet weak var seeDetailsButton: UIButton!
    @IBOutlet weak var filmsCollectionView: UICollectionView!
    @IBOutlet weak var releaseDateLabel: UILabel!

    var selectedMovie: Movie?
    var selectedFilm: Film?
    var selectedMovieChars: [String]?
    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        initViewModel()
        setUpViews()
        viewModel.callMovieList()
    }

    private func initViewModel() {
        viewModel.onSelectedMovie = { [weak self] movie, chars in
            guard let self = self else { return }
            self.setSelectedMovieDetails(movie: movie)
            self.selectedMovieChars = chars
        }

        viewModel.onFinish = { [weak self] in
            guard let self = self else { return }
            self.selectedMovie = self.viewModel.getMovieAtIndex(0)
            DispatchQueue.main.sync {
                self.filmsCollectionView.reloadData()
            }
            SVProgressHUD.dismiss()
        }
    }

    private func setUpViews() {
        seeDetailsButton.setTitle(NSLocalizedString(StringConstants.seeDetails, comment: ""), for: .normal)
        filmsLabel.text = NSLocalizedString(StringConstants.filmsLabel, comment: "")
        movieViewBackground.layer.cornerRadius = 10
        let nib = UINib(nibName: MovieCollectionViewCell.nibName, bundle: nil)
        filmsCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        filmsCollectionView.dataSource = self
        filmsCollectionView.delegate = self
    }

    @IBAction func movieDetailsButtonAction(_ sender: Any) {
        guard let selectedMovie = selectedMovie, let charsList = selectedMovieChars else {return}
        let vc = MovieDetailViewController(movie: selectedMovie, charactersList: charsList)
//        vc.movieDetail = selectedMovie ?? Movie()
        show(vc, sender: nil)
    }

    private func setSelectedMovieDetails(movie: Movie) {
        DispatchQueue.main.sync {
            movieViewBackground.isHidden = false
            changeSelectedMovie(movie: movie)
        }
    }

    private func changeSelectedMovie(movie: Movie) {
        selectedMovie = movie
        releaseDateLabel.text = movie.releaseDate.getLocalString()
        selMovieTitleLabel.text = movie.title
        selMovieCrawlLabel.text = movie.openingCrawl
        selMovieImage.image = getImageForMovie(movie.title)
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

// MARK: Collection view delegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.moviesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = viewModel.getMovieAtIndex(indexPath.row)
        let identifier = MovieCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCollectionViewCell
        guard let movieCell = cell else { return UICollectionViewCell() }
        movieCell.setValues(movie: movie, image: getImageForMovie(movie.title))
        return movieCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.getMovieAtIndex(indexPath.row)
        changeSelectedMovie(movie: movie)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.5
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
