//
//  PlanetTableViewCell.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 30/11/22.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var terrainLabel: UILabel!
    @IBOutlet weak var viewWrapper: UIView!
    static let nibName = "PlanetTableViewCell"
    static let identifier = "PlanetTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        viewWrapper.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(planet: Planet) {
        nameLabel.text = planet.name
        climateLabel.text = planet.climate
        terrainLabel.text = planet.terrain
    }

}
