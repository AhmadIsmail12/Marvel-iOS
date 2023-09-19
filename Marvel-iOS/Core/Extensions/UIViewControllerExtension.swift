//
//  UIViewControllerExtension.swift
//  Mavel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit
import Foundation

extension UIViewController {
    // This Function Loades the view controller from Nib File
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            var nibName = String(describing: T.self)
            if let index = nibName.range(of: "<")?.lowerBound {
                let substring = nibName[..<index]
                nibName = String(substring)
            }
            return T(nibName: nibName, bundle: Bundle(for: Self.self))
        }
        return instantiateFromNib()
    }
}

