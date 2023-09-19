//
//  CharacterDetailsViewModel.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import Foundation

public final class CharacterDetailsViewModel {
    
    // MARK: - Variables
    var character: Character
    var comics: [CharacterContent] = []
    var events: [CharacterContent] = []
    var stories: [CharacterContent] = []
    var series: [CharacterContent] = []
    var dataSource: Observable<[CharacterDetailsCellType]> = Observable([.header])
    var loading: Observable<Bool> = Observable(false)
    
    // MARK: - Init
    public init(character: Character) {
        self.character = character
    }

    public func viewDidLoad() {
        generateDataSource()
        loading.value = true
        fetchAllData {
            self.generateDataSource()
            self.loading.value = false
        }
    }
    
    // MARK: - Private
    private func generateDataSource() {
        var tempDataSource: [CharacterDetailsCellType] = [
            .header
        ]
        if comics.isEmpty == false {
            tempDataSource.append(.content("Comics", comics))
        }
        if events.isEmpty == false {
            tempDataSource.append(.content("Events", events))
        }
        if stories.isEmpty == false {
            tempDataSource.append(.content("Stories", stories))
        }
        if series.isEmpty == false {
            tempDataSource.append(.content("Series", series))
        }
        self.dataSource.value = tempDataSource
    }
    
    private func fetchAllData(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        getComics {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        getEvents {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        getStories {
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        getSeries {
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    private func getComics(completion: @escaping () -> Void) {
        if let characterId = character.id {
            let params = CharacterContentParams(limit: 3)
            ApiManager.shared.getCharacterContentApi(
                path: "/v1/public/characters/\(characterId)/comics",
                params: params
            ) { Result in
                switch Result {
                case.success(let result):
                    if let comics = result.data?.results,
                       comics.isEmpty == false {
                        self.comics = comics
                    }
                case .failure(let error):
                    print("Error : \(error.localizedDescription)")
                }
                completion()
            }
        }
    }
    
    private func getEvents(completion: @escaping () -> Void) {
        if let characterId = character.id {
            let params = CharacterContentParams(limit: 3)
            ApiManager.shared.getCharacterContentApi(
                path: "/v1/public/characters/\(characterId)/events",
                params: params
            ) { Result in
                switch Result {
                case.success(let result):
                    if let events = result.data?.results,
                       events.isEmpty == false {
                        self.events = events
                    }
                case .failure(let error):
                    print("Error : \(error.localizedDescription)")
                }
                completion()
            }
        }
    }
    
    private func getStories(completion: @escaping () -> Void) {
        if let characterId = character.id {
            let params = CharacterContentParams(limit: 3)
            ApiManager.shared.getCharacterContentApi(
                path: "/v1/public/characters/\(characterId)/stories",
                params: params
            ) { Result in
                switch Result {
                case.success(let result):
                    if let stories = result.data?.results,
                       stories.isEmpty == false {
                        self.stories = stories
                    }
                case .failure(let error):
                    print("Error : \(error.localizedDescription)")
                }
                completion()
            }
        }
    }
    
    private func getSeries(completion: @escaping () -> Void) {
        if let characterId = character.id {
            let params = CharacterContentParams(limit: 3)
            ApiManager.shared.getCharacterContentApi(
                path: "/v1/public/characters/\(characterId)/series",
                params: params
            ) { Result in
                switch Result {
                case.success(let result):
                    if let series = result.data?.results,
                       series.isEmpty == false {
                        self.series = series
                    }
                case .failure(let error):
                    print("Error : \(error.localizedDescription)")
                }
                completion()
            }
        }
    }
}
