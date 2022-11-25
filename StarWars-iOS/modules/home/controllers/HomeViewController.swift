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

    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        self.title = StringConstants.appTitle
        initViewModel()
        setUpViews()
        viewModel.callMovieList()
    }

    private func initViewModel() {
        viewModel.onSelectedMovie = { [weak self] movie in
            guard let self = self else { return }
            self.setSelectedMovieDetails(movie: movie)
        }

        viewModel.onFinish = { [weak self] in
            guard self != nil else { return }
            SVProgressHUD.dismiss()
        }
    }

    private func setUpViews() {
        seeDetailsButton.setTitle(NSLocalizedString(StringConstants.seeDetails, comment: ""), for: .normal)
        filmsLabel.text = NSLocalizedString(StringConstants.filmsLabel, comment: "")
    }

    @IBAction func movieDetailsButtonAction(_ sender: Any) {
    }

    private func setSelectedMovieDetails(movie: Movie) {
        DispatchQueue.main.sync {
            switch movie.title {
            case "A New Hope":
                selMovieImage.image = UIImage(named: StringConstants.newHope)
            default:
                break
            }
            movieViewBackground.isHidden = false
            selMovieTitleLabel.text = movie.title
            selMovieCrawlLabel.text = movie.openingCrawl
        }
    }
}
