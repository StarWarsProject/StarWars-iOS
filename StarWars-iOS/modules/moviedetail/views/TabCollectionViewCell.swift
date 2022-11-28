//
//  TabCollectionViewCell.swift
//  StarWars-iOS
//
//  Created by User on 28/11/22.
//

import UIKit

class TabCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lineTabView: UIView!

    static let nibName = "TabCollectionViewCell"
    static let identifier = "TabCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValues(tab: String) {
        descriptionLabel.text = tab
    }

}
