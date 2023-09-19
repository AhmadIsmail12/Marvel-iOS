//
//  CharacterTableViewCell.swift
//  Mavel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - IBOultets
    // Always setting IBOutlets to private to not be accessed only by it self
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var characterImageView: UIImageView!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addRoundCorners(radius: 12)
        characterImageView.addRoundCorners(radius: 12)
        selectionStyle = .none
    }
    
    // MARK: - Setup
    func setupCell(character: Character) {
        self.characterNameLabel.text = character.name
        if let thumbnail = character.thumbnail {
            let imageURL = thumbnail.getImageUrl()
            self.characterImageView.setImage(imageURL, placeholder: UIImage(named: "logo"))
        }
    }
}
