//
//  Coordinator.swift
//  Mavel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit
import Foundation

// Using Coordinator Pattern
public final class Coordinator {
    
    public var navigationController = UINavigationController()
    private let window: UIWindow
    private let appDIContainer: AppDIContainer
    
    init(window: UIWindow, appDIContainer: AppDIContainer) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showCharactersViewController()
    }
    
    func showCharactersViewController() {
        let charactersViewController = appDIContainer.makeCharactersViewController(
            closures: CharactersViewModelClosures(
                showCharacterDetailsViewController: showCharacterDetailsViewController
            )
        )
        self.navigationController.setViewControllers([charactersViewController], animated: true)
    }
    
    func showCharacterDetailsViewController(character: Character) {
        let characterDetailsViewController = appDIContainer.makeCharacterDetailsViewController(
            character: character
        )
        self.navigationController.pushViewController(characterDetailsViewController, animated: true)
    }
}
