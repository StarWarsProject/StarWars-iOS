//
//  ShipTableViewCell.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 5/12/22.
//

import UIKit

class ShipTableViewCell: UITableViewCell {

    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var crewNumberLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    static let nibName = "ShipTableViewCell"
    static let identifier = "ShipTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        viewWrapper.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(ship: Starship) {
        shipNameLabel.text = ship.name
        crewNumberLabel.text = ship.crew
        manufacturerLabel.text = ship.manufacturer
    }
}
