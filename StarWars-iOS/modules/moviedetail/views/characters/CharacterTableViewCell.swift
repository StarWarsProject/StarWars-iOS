//
//  CharacterTableViewCell.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 29/11/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var viewWrapper: UIView!
    static let nibName = "CharacterTableViewCell"
    static let identifier = "CharacterTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        viewWrapper.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(character: Character) {
        nameLabel.text = character.name
        birthLabel.text = character.birth
        genderLabel.text = character.gender
    }
}
