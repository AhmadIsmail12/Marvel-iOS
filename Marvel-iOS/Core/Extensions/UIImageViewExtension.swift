//
//  UIImageViewExtension.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    // Using KingFisher to set load image
    func setImage(_ stringURL: String?, placeholder: UIImage? = nil, completionHandler: (() -> Void)? = nil) {
        guard let stringURL = stringURL,
            let url = URL(string: stringURL) else {
                self.image = placeholder
                return
        }
        self.kf.indicatorType = .activity
        if let completionHandler = completionHandler {
            self.kf.setImage(with: url, placeholder: placeholder,
                             completionHandler: { _ in
                                completionHandler()
            })
        } else {
            self.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(1.0))])
        }
    }
}
