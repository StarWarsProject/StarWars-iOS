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

    static let nibName = "MovieCollectionViewCell"
    static let identifier = "MovieCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        cardBackground.layer.cornerRadius = 10
    }

    func setValues(movie: Movie, image: UIImage?) {
        movieTitleLabel.text = movie.title
        movieImage.image = image
    }
}
