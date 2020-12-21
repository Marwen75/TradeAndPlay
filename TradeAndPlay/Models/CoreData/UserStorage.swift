//
//  FakeUserStorage.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 20/12/2020.
//

import Foundation
import CoreData

class UserStorage {
    
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
        guard let fetchResults = try? objectContext.fetch(request), fetchResults.count > 0 else {
            completionHandler(.failure(.noPlayerFound))
            return
        }
        completionHandler(.success(fetchResults))
    }
    
    func addFakeUser(name: String, city: String, rating: Int64) -> User {
        let user = User(context: objectContext)
        user.nickname = name
        user.city = city
        user.rating = rating
        coreDataStack.saveContext()
        return user
    }
    
    func addGame(name: String, cover: String, platform: String) -> OwnedGame {
        let game = OwnedGame(context: objectContext)
        game.name = name
        game.cover = cover
        game.platform = cover
        return game
    }
    
    func addSearchGame(name: String, cover: String, platform: String) -> SearchedGame {
        let game = SearchedGame(context: objectContext)
        game.platform = platform
        game.cover = cover
        game.name = name
        return game
    }
    
    func addFakeConv() -> [Message] {
        let message = Message(context: objectContext)
        message.content = "Hey"
        message.date = Date()
        return [message]
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
        request.predicate = NSPredicate(format: "ANY ownedGames.name == %@", name)
        guard let fetchResults = try? objectContext.fetch(request), fetchResults.count > 0 else {
            completionHandler(.failure(.noPlayerWithGameFound))
            return
        }
        completionHandler(.success(fetchResults))
    }
}


