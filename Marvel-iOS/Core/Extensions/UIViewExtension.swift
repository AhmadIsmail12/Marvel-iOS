//
//  UIViewExtension.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit
import Foundation

extension UIView {
    
    func addRoundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
