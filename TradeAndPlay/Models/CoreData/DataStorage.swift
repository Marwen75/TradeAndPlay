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
    
    func fetchStoredGames(completionHandler: @escaping (Result<[StoredGame], DataStorageError>) -> Void) {
        let request: NSFetchRequest<StoredGame> = StoredGame.fetchRequest()
        guard let games = try? objectContext.fetch(request) else {
            completionHandler(.failure(.noGameFound))
            return
        }
        completionHandler(.success(games))
    }
    
    func fetchSearchedGames(completionHandler: @escaping (Result<[SearchedGame], DataStorageError>) -> Void) {
        let request: NSFetchRequest<SearchedGame> = SearchedGame.fetchRequest()
        guard let games = try? objectContext.fetch(request) else {
            completionHandler(.failure(.noGameFound))
            return
        }
        completionHandler(.success(games))
    }
    
    func fetchUsers(named name: String, completionHandler: @escaping (Result<[User], DataStorageError>) -> Void) {
        let request: NSFetchRequest<User> =
            User.fetchRequest()
        request.predicate = NSPredicate(format: "nickname == %@", name)
        guard let fetchResults = try? objectContext.fetch(request), fetchResults.count > 0 else {
            completionHandler(.failure(.noPlayerFound))
            return
        }
        completionHandler(.success(fetchResults))
    }
    
    func addFakeUser(name: String, city: String, rating: Int64) {
        let user = User(context: objectContext)
        user.nickname = name
        user.city = city
        user.rating = rating
        user.addToStoredGames(addGame())
        coreDataStack.saveContext()
    }
    
    func addGame() -> StoredGame {
        let game = StoredGame(context: objectContext)
        //Optional("co286o")
        //Optional("Dino Crisis")
        game.cover = "co286o"
        game.name = "Dino Crisis"
        return game
    }
    
    func deleteFakeUsers() {
        let request: NSFetchRequest<User> =
            User.fetchRequest()
        //request.predicate = NSPredicate(format: "nickname == %@", "Toto", "Max", "Eve" , "Frea", "Jim")
        do {
            let fetchResults = try objectContext.fetch(request)
            fetchResults.forEach { objectContext.delete($0) }
        } catch let error as NSError {
            print(error.userInfo)
        }
        coreDataStack.saveContext()
    }
    
    func fetchUsersWhoHasGame(named name: String, completionHandler: @escaping (Result<[User], DataStorageError>) -> Void) {
        let request: NSFetchRequest<User> =
            User.fetchRequest()
        request.predicate = NSPredicate(format: "ANY storedGames.name == %@", name)
        guard let fetchResults = try? objectContext.fetch(request), fetchResults.count > 0 else {
            completionHandler(.failure(.noPlayerWithGameFound))
            return
        }
        completionHandler(.success(fetchResults))
    }
    
    func addToLibrary(game: GameModel, platformIndex: Int, completionHandler: @escaping (Result<String, DataStorageError>) -> Void) {
        let gameToAddInLibrary = StoredGame(context: objectContext)
        let request: NSFetchRequest<StoredGame> =
            StoredGame.fetchRequest()
        guard let platforms = game.platforms else {return}
        let predicate1 = NSPredicate(format: "name == %@", game.name)
        let predicate2 = NSPredicate(format: "platform == %@", platforms[platformIndex])
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        guard let fetchResults = try? objectContext.fetch(request), fetchResults.count < 1 else {
            completionHandler(.failure(.alreadyInSearchList))
            return
        }
        gameToAddInLibrary.name = game.name
        gameToAddInLibrary.cover = game.cover
        gameToAddInLibrary.platform = game.platforms?[platformIndex]
        gameToAddInLibrary.isTraded = game.isTraded
        coreDataStack.saveContext()
        completionHandler(.success(fetchResults.first?.name ?? "NoName"))
    }
    
    func addToSearchList(game: GameModel, platformIndex: Int, completionHandler: @escaping (Result<String, DataStorageError>) -> Void) {
        let gameToAddInList = SearchedGame(context: objectContext)
        let request: NSFetchRequest<SearchedGame> =
            SearchedGame.fetchRequest()
        guard let platforms = game.platforms else {return}
        let predicate1 = NSPredicate(format: "name == %@", game.name)
        let predicate2 = NSPredicate(format: "platform == %@", platforms[platformIndex])
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        guard let fetchResults = try? objectContext.fetch(request), fetchResults.count < 1 else {
            completionHandler(.failure(.alreadyInSearchList))
            return
        }
        gameToAddInList.name = game.name
        gameToAddInList.cover = game.cover
        gameToAddInList.platform = platforms[platformIndex]
        coreDataStack.saveContext()
        completionHandler(.success(fetchResults.first?.name ?? "NoName"))
    }
    
    func deleteGame() {
        let request: NSFetchRequest<StoredGame> =
            StoredGame.fetchRequest()
        //request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let fetchResults = try objectContext.fetch(request)
            fetchResults.forEach { objectContext.delete($0) }
            //completionHandler()
        } catch let error as NSError {
            print(error.userInfo)
        }
        coreDataStack.saveContext()
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
    
    func checkInLibraryForGame(named name: String, completionHandler: @escaping (Result<StoredGame, DataStorageError>) -> Void) {
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
