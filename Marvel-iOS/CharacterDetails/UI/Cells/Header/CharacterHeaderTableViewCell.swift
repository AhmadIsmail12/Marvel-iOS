//
//  CharacterHeaderTableViewCell.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit

class CharacterHeaderTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    // MARK: - Setup
    func setupCell(character: Character) {
        self.characterNameLabel.text = character.name
        self.characterDescriptionLabel.text = character.description
        if let thumbnail = character.thumbnail {
            let imageURL = thumbnail.getImageUrl()
            self.characterImageView.setImage(imageURL, placeholder: UIImage(named: "logo"))
        }
    }
}
