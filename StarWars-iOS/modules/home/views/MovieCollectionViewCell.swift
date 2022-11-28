//
//  MovieCollectionViewCell.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 25/11/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardBackground: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    static let nibName = "MovieCollectionViewCell"
    static let identifier = "MovieCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        cardBackground.layer.cornerRadius = 10
        cardBackground.clipsToBounds = true
    }

    func setValues(movie: Movie, image: UIImage?) {
        releaseDateLabel.text = movie.releaseDate.getLocalString()
        movieTitleLabel.text = movie.title
        movieImage.image = image
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 0.2]
        containerView.layer.insertSublayer(gradient, at: 0)
    }
}
