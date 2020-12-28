//
//  GameStorage.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 15/12/2020.
//

import Foundation
import CoreData

// This object will serve as our game storage
class GameStorage {
    
    // MARK: - Properties
    private let objectContext: NSManagedObjectContext
    private let coreDataStack: CoreDataStack
    
    // MARK: - Init
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.objectContext = coreDataStack.viewContext
    }
    
    // MARK: - CRUD
    func fetchOwnedGames(completionHandler: @escaping (Result<[OwnedGame], DataStorageError>) -> Void) {
        let request: NSFetchRequest<OwnedGame> = OwnedGame.fetchRequest()
        do {
            let fetchResults = try objectContext.fetch(request)
            guard fetchResults.count >= 0 else {
                completionHandler(.failure(.noGameFound))
                return
            }
            completionHandler(.success(fetchResults))
        } catch let error {
            print(error)
        }
    }
    
    func fetchSearchedGames(completionHandler: @escaping (Result<[SearchedGame], DataStorageError>) -> Void) {
        let request: NSFetchRequest<SearchedGame> = SearchedGame.fetchRequest()
        do {
            let fetchResults = try objectContext.fetch(request)
            guard fetchResults.count >= 0 else {
                completionHandler(.failure(.noGameFound))
                return
            }
            completionHandler(.success(fetchResults))
        } catch let error {
            print(error)
        }
    }
    
    func addToOwnedList(game: GameModel, platform: String, completionHandler: @escaping (Result<String, DataStorageError>) -> Void) {
        checkInLibraryForOwnedGame(game: game, completionHandler: { result in
            guard result == false else {
                completionHandler(.failure(.alreadyInOwnedList))
                return
            }
            let gameToAddInLibrary = OwnedGame(context: self.objectContext)
            gameToAddInLibrary.name = game.name
            gameToAddInLibrary.cover = game.cover
            gameToAddInLibrary.platform = game.platform
            gameToAddInLibrary.isTraded = false
            completionHandler(.success(game.name))
        })
        coreDataStack.saveContext()
    }
    
    func addToSearchList(game: GameModel, platform: String, completionHandler: @escaping (Result<String, DataStorageError>) -> Void) {
        checkInLibraryForSearchedGame(game: game, completionHandler: { result in
            guard result == false else {
                completionHandler(.failure(.alreadyInSearchList))
                return
            }
            let gameToAddInLibrary = SearchedGame(context: self.objectContext)
            gameToAddInLibrary.name = game.name
            gameToAddInLibrary.cover = game.cover
            gameToAddInLibrary.platform = game.platform
            completionHandler(.success(game.name))
        })
        coreDataStack.saveContext()
    }
    
    func deleteFromOwnedList(gameNamed name: String, completionHandler: @escaping () -> Void) {
        let request: NSFetchRequest<OwnedGame> =
            OwnedGame.fetchRequest()
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
    
    func deleteFromSearchList(gameNamed name: String, completionHandler: @escaping () -> Void) {
        let request: NSFetchRequest<SearchedGame> =
            SearchedGame.fetchRequest()
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
    
    func checkInLibraryForOwnedGame(game: GameModel, completionHandler: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<OwnedGame> = OwnedGame.fetchRequest()
        let predicate1 = NSPredicate(format: "name == %@", game.name)
        let predicate2 = NSPredicate(format: "platform == %@", game.platform)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        do {
            let fetchResults = try objectContext.fetch(request)
            guard fetchResults.count == 0 else {
                completionHandler(true)
                return
            }
            completionHandler(false)
        }
        catch let error {
            print(error)
        }
    }
    
    func checkInLibraryForSearchedGame(game: GameModel, completionHandler: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<SearchedGame> = SearchedGame.fetchRequest()
        let predicate1 = NSPredicate(format: "name == %@", game.name)
        let predicate2 = NSPredicate(format: "platform == %@", game.platform)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        do {
            let fetchResults = try objectContext.fetch(request)
            guard fetchResults.count == 0 else {
                completionHandler(true)
                return
            }
            completionHandler(false)
        }
        catch let error {
            print(error)
        }
    }
    
    func fetchCurrentTrades(completionHandler: @escaping (Result<[OwnedGame], DataStorageError>) -> Void) {
        let request: NSFetchRequest<OwnedGame> = OwnedGame.fetchRequest()
        request.predicate = NSPredicate(format: "isTraded == %@" ,NSNumber(booleanLiteral: true))
        guard let trades = try? objectContext.fetch(request) else {
            completionHandler(.failure(.noCurrentTrade))
            return
        }
        completionHandler(.success(trades))
    }
    
    func addTrade(game: OwnedGame, recipient: FakeUser) {
        let trade = Trade(context: objectContext)
        trade.beginAt = Date.init()
        trade.recipient = recipient.nickName
        game.trade = trade
        game.isTraded = true
        coreDataStack.saveContext()
    }
    
    func deleteTrade(game: OwnedGame) {
        guard let gameName = game.name else {return}
        let request: NSFetchRequest<Trade> = Trade.fetchRequest()
        request.predicate = NSPredicate(format: "ownedGame.name == %@", gameName)
        do {
            let trades = try objectContext.fetch(request)
            guard let trade = trades.last else {return}
            objectContext.delete(trade)
            game.isTraded = false
            coreDataStack.saveContext()
        } catch let error {
            print(error)
        }
    }
}
