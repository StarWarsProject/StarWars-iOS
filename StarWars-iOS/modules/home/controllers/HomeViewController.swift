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
    let viewModel = HomeViewModel()
    let sharedFunctions = SharedFunctions()

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        initViewModel()
        setUpViews()
        viewModel.callMovieList()
    }

    private func initViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.filmsCollectionView.reloadData()
            }
        }

        viewModel.onSelectedMovie = { [weak self] movie in
            guard let self = self else { return }
            self.setSelectedMovieDetails(movie: movie)
        }

        viewModel.onFinish = { [weak self] in
            guard let self = self else { return }
            self.selectedMovie = self.viewModel.getMovieAtIndex(0)
            print(self.viewModel.getMovieAtIndex(0))
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
        let movie = viewModel.getMovieAtIndex(viewModel.movieIndex)
        let vc = MovieDetailViewController(movie: movie)
        show(vc, sender: nil)
    }

    @IBAction func sortMovies(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let sortReleaseAsc = UIAlertAction(title: NSLocalizedString(StringConstants.sortDateAsc,
                                                                    comment: ""),
                                            style: .default) { _ in
            self.viewModel.sortMovies(field: .ReleaseDate, criteria: .Ascending)
            actionSheet.dismiss(animated: true)
        }

        let sortReleaseDesc = UIAlertAction(title: NSLocalizedString(StringConstants.sortDateDesc,
                                                                     comment: ""),
                                            style: .default) { _ in
            self.viewModel.sortMovies(field: .ReleaseDate, criteria: .Desceding)
            actionSheet.dismiss(animated: true)
        }

        let sortCronAsc = UIAlertAction(title: NSLocalizedString(StringConstants.sortCronAsc,
                                                                 comment: ""),
                                         style: .default) { _ in
            self.viewModel.sortMovies(field: .EpisodeCronId, criteria: .Ascending)
            actionSheet.dismiss(animated: true)
        }

        let sortCronDesc = UIAlertAction(title: NSLocalizedString(StringConstants.sortCronDesc,
                                                                  comment: ""),
                                         style: .default) { _ in
            self.viewModel.sortMovies(field: .EpisodeCronId, criteria: .Desceding)
            actionSheet.dismiss(animated: true)
        }

        let cancelAction = UIAlertAction(title: NSLocalizedString(StringConstants.cancel,
                                                                  comment: ""), style: .cancel) { _ in
            actionSheet.dismiss(animated: true)
        }

        actionSheet.addAction(sortReleaseAsc)
        actionSheet.addAction(sortReleaseDesc)
        actionSheet.addAction(sortCronAsc)
        actionSheet.addAction(sortCronDesc)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }

    private func setSelectedMovieDetails(movie: Movie) {
        DispatchQueue.main.async {
            self.movieViewBackground.isHidden = false
            self.changeSelectedMovie(movie: movie)
        }
    }

    private func changeSelectedMovie(movie: Movie) {
        selectedMovie = movie
        releaseDateLabel.text = movie.releaseDate.getLocalString()
        selMovieTitleLabel.text = movie.title
        selMovieCrawlLabel.text = movie.openingCrawl
        selMovieImage.image = sharedFunctions.getImageForMovie(movie.title)
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
        movieCell.setValues(movie: movie, image: sharedFunctions.getImageForMovie(movie.title))
        return movieCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.getMovieAtIndex(indexPath.row)
        viewModel.movieIndex = indexPath.row
        changeSelectedMovie(movie: movie)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.5
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
