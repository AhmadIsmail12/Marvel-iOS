//
//  CharactersViewModel.swift
//  Mavel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit
import Foundation
import CoreData

public final class CharactersViewModel {
    
    // MARK: - Variables
    private let closures: CharactersViewModelClosures?
    // Using Observable Pattern
    var characters: Observable<[Character]> = Observable([])
    var isLoading = false
    var isEmpty: Bool { return characters.value.isEmpty }
    
    // MARK: - Init
    public init(closures: CharactersViewModelClosures?) {
        self.closures = closures
    }
    
    public func viewDidLoad() {
        getCharactersFromLocalData {
            self.getCharacters()
        }
    }
    
    // MARK: - Public
    public func didSelectItem(indexPath: IndexPath) {
        let character = characters.value[indexPath.row]
        closures?.showCharacterDetailsViewController(character)
    }
    
    // MARK: - Private
    // Get List of characters From API
    private func getCharacters() {
        isLoading = true
        ApiManager.shared.getCharactersApi(path: "/v1/public/characters", params: nil) { Result in
            switch Result {
            case.success(let result):
                if let characters = result.data?.results,
                   characters.isEmpty == false {
                    self.characters.value = characters
                    self.isLoading = false
                    // Delete Stored Data
                    self.deleteData {
                        // Store Data retireved From API to Core Data
                        self.storeData(characters: characters)
                    }
                }
            case .failure(let error):
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    // Get Characters From Core Data
    private func getCharactersFromLocalData(completion : @escaping (() -> Void)) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Characters")
        do {
            var rowsCoreData = [NSManagedObject]()
            var tempCharacters: [Character] = []
            rowsCoreData = try context.fetch(request) as! [NSManagedObject]
            DispatchQueue.main.async {
                for result in rowsCoreData {
                    tempCharacters.append(
                        Character(
                            id: (result.value(forKey: "id") as? Int),
                            name: (result.value(forKey: "name") as? String),
                            description: (result.value(forKey: "descriptionField") as? String),
                            thumbnail: Image(
                                path: (result.value(forKey: "imagePath") as? String),
                                fileExtension: (result.value(forKey: "imageExtension") as? String)
                            )
                        )
                    )
                }
                self.characters.value = tempCharacters
            }
            completion()
        } catch {
            print("There  was a fetch error!")
            completion()
        }
    }
    
    private func storeData(characters: [Character]) {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            for character in characters {
                let newRow = NSEntityDescription.insertNewObject(forEntityName: "Characters", into: context)
                newRow.setValue(character.id, forKey: "id")
                newRow.setValue(character.name, forKey: "name")
                newRow.setValue(character.description, forKey: "descriptionField")
                newRow.setValue(character.thumbnail?.fileExtension, forKey: "imageExtension")
                newRow.setValue(character.thumbnail?.path, forKey: "imagePath")
            }
            do {
                try context.save()
            } catch {
                print("Failed Saving")
            }
        }
    }
    
    // This Function delete the stored Data
    private func deleteData(completion : @escaping (() -> Void)) {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            fetchRequest = NSFetchRequest(entityName: "Characters")
            // Create a batch delete request for the
            // fetch request
            let deleteRequest = NSBatchDeleteRequest(
                fetchRequest: fetchRequest
            )
            deleteRequest.resultType = .resultTypeObjectIDs

            // Perform the batch delete
            do {
                let batchDelete = try context.execute(deleteRequest)
                    as? NSBatchDeleteResult
                completion()
            } catch {
                print("Failed Deleting")
            }
        }
    }
}
