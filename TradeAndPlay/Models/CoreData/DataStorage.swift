//
//  DataStorage.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 10/12/2020.
//

import Foundation
import CoreData

class DataStorage {
    
    // MARK: - Properties
    private let objectContext: NSManagedObjectContext
    private let coreDataStack: CoreDataStack
    
    // MARK: - Init
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.objectContext = coreDataStack.viewContext
    }
    
    // MARK: - CRUD
    
    func fetchUsers(named name: String, completionHandler: @escaping (Result<[User], DataStorageError>) -> Void) {
        let request: NSFetchRequest<User> =
            User.fetchRequest()
        request.predicate = NSPredicate(format: "nickname == %@", name)
        if let fetchResults = try? objectContext.fetch(request) {
            completionHandler(.success(fetchResults))
        }
        completionHandler(.failure(.noPlayerFound))
    }
    
    
    func addToLibrary(game: Game, index: Int, completionHandler: @escaping () -> Void) {
        let gameToStore = StoredGame(context: objectContext)
        gameToStore.name = game.name
        gameToStore.cover = game.cover?.image_id
        gameToStore.platform = game.platforms?[index].name
        coreDataStack.saveContext()
        completionHandler()
    }
    
    func deleteFromLibrary(gameNamed name: String, completionHandler: @escaping () -> Void) {
        let request: NSFetchRequest<StoredGame> =
            StoredGame.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let fetchResults = try objectContext.fetch(request)
            fetchResults.forEach { objectContext.delete($0) }
            completionHandler()
        } catch let error as NSError {
            print(error.userInfo)
        }
        coreDataStack.saveContext()
    }
    
    func checkForGameInLibrary(named name: String, completionHandler: @escaping (Result<StoredGame, DataStorageError>) -> Void) {
        let request: NSFetchRequest<StoredGame> =
            StoredGame.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        guard let fetchResults = try? objectContext.fetch(request) else {
            completionHandler(.failure(.noGameFound))
            return
        }
        completionHandler(.success(fetchResults.first!))
    }
}
