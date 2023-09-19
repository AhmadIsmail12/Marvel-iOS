//
//  AppDIContainer.swift
//  Mavel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import Foundation

// MARK: - Dependecy Injection
public final class AppDIContainer {
    
    // MARK: - View Model
    func makeCharactersViewModel(closures: CharactersViewModelClosures?) -> CharactersViewModel {
        return CharactersViewModel(
            closures: closures
        )
    }
    
    func makeCharacterDetailsViewModel(character: Character) -> CharacterDetailsViewModel {
        return CharacterDetailsViewModel(
            character: character
        )
    }
    
    // MARK: - View Controllers
    func makeCharactersViewController(closures: CharactersViewModelClosures?)
    -> CharactersViewController {
        return CharactersViewController.create(
            with: makeCharactersViewModel(closures: closures)
        )
    }
    
    func makeCharacterDetailsViewController(character: Character)
    -> CharacterDetailsViewController {
        return CharacterDetailsViewController.create(
            with: makeCharacterDetailsViewModel(character: character)
        )
    }
}
