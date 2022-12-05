//
//  VehicleTableViewCell.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 5/12/22.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var viewWrapper: UIView!
    static let nibName = "VehicleTableViewCell"
    static let identifier = "VehicleTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        viewWrapper.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(vehicle: Vehicle) {
        nameLabel.text = vehicle.name
        modelLabel.text = vehicle.model
        manufacturerLabel.text = vehicle.manufacturer
    }
}
