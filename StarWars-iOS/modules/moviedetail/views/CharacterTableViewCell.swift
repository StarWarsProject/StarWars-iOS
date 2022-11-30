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

    static let nibName = "CharacterTableViewCell"
    static let identifier = "CharacterTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
    }

    func setData(character: Character) {
        nameLabel.text = character.name
        birthLabel.text = character.birth
        genderLabel.text = character.gender
    }
}
