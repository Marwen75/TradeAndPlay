//
//  MessageStorage.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 19/12/2020.
//

import Foundation
import CoreData

class MessageStorage {
    
    // MARK: - Properties
    private let objectContext: NSManagedObjectContext
    private let coreDataStack: CoreDataStack
    
    // MARK: - Init
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.objectContext = coreDataStack.viewContext
    }
    
    func addMessage(content: String, date: Date, completionHandler: (() -> Void)) {
        let message = Message(context: objectContext)
        message.content = content
        message.date = date
        message.isReceiving = true
        completionHandler()
        coreDataStack.saveContext()
    }
    
    func fetchSenders(completionHandler: @escaping (Result<[String], DataStorageError>) -> Void) {
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        do {
            let fetchResults = try objectContext.fetch(request)
            guard fetchResults.count > 0 else {
                completionHandler(.failure(.noDiscussion))
                return
            }
            var senderNames: [String] = []
            fetchResults.forEach({senderNames.append($0.senderName ?? "Raté")})
            completionHandler(.success(senderNames))
        } catch let error {
            print(error)
        }
    }
    
    func fetchDiscussion(senderName: String, completionHandler: @escaping (Result<[String], DataStorageError>) -> Void) {
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "senderName == %@", senderName)
        do {
            let fetchResults = try objectContext.fetch(request)
            guard fetchResults.count > 0 else {
                completionHandler(.failure(.noDiscussion))
                return
            }
            var messages: [String] = []
            fetchResults.forEach({messages.append($0.content ?? "Raté")})
            completionHandler(.success(messages))
        } catch let error {
            print(error)
        }
    }
}
