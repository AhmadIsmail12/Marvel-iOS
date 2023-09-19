//
//  CharacterShimmerTableViewCell.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit

class CharacterShimmerTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    // Always setting IBOutlets to private to not be accessed only by it self
    @IBOutlet private weak var labelContainerView: ShimmerView!
    @IBOutlet private weak var imageContainerView: ShimmerView!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        labelContainerView.addRoundCorners(radius: 12)
        imageContainerView.addRoundCorners(radius: 12)
    }
    
    func animate() {
        labelContainerView.startAnimating()
        imageContainerView.startAnimating()
    }
    
}
