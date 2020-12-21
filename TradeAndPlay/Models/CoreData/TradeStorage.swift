//
//  TradeStorage.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 15/12/2020.
//

import Foundation
import CoreData

class TradeStorage {
    
    // MARK: - Properties
    private let objectContext: NSManagedObjectContext
    private let coreDataStack: CoreDataStack
    
    // MARK: - Init
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.objectContext = coreDataStack.viewContext
    }
    
    func fetchTrades(completionHandler: @escaping (Result<[Trade], DataStorageError>) -> Void) {
        let request: NSFetchRequest<Trade> = Trade.fetchRequest()
        guard let trades = try? objectContext.fetch(request) else {
            completionHandler(.failure(.noCurrentTrade))
            return
        }
        completionHandler(.success(trades))
    }
    
    func addTrade(giving game: OwnedGame, receiving searchedGame: SearchedGame, date: Date) {
        
    }
}
