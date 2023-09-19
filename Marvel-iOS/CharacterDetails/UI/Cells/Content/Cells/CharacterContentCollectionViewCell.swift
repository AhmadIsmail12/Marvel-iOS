//
//  CharacterContentCollectionViewCell.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit

class CharacterContentCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var contentImageView: UIImageView!
    @IBOutlet private weak var contentTitleLabel: UILabel!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addRoundCorners(radius: 12)
    }
    
    // MARK: - Setup
    func setupCell(content: CharacterContent) {
        self.contentTitleLabel.text = content.title
        if let thumbnail = content.thumbnail {
            let imageURL = thumbnail.getImageUrl()
            self.contentImageView.contentMode = .scaleAspectFill
            self.contentImageView.setImage(imageURL)
        } else {
            self.contentImageView.image = UIImage(named: "logo")
            self.contentImageView.contentMode = .scaleAspectFit
        }
    }

}
