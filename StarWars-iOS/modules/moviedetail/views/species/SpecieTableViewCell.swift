//
//  SpecieTableViewCell.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 2/12/22.
//

import UIKit

class SpecieTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var viewWrapper: UIView!
    static let nibName = "SpecieTableViewCell"
    static let identifier = "SpecieTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        viewWrapper.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(specie: Specie) {
        nameLabel.text = specie.name
        classificationLabel.text = specie.classification
        languageLabel.text = specie.language
    }
}
