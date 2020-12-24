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
    
    func addFakeDiscussion(fakeUser: FakeUser) {
        let discussion = Discussion(context: objectContext)
        let message = Message(context: objectContext)
        message.content = fakeUser.messages.last?.content
        message.isReceiving = true
        message.date = fakeUser.messages.last?.date
        discussion.recipient = fakeUser.nickName
        discussion.date = fakeUser.messages.last?.date
        discussion.addToMessages(message)
        coreDataStack.saveContext()
    }
    
    func addNewDiscussion(recipient: FakeUser) {
        let discussion = Discussion(context: objectContext)
        discussion.recipient = recipient.nickName
        discussion.date = Date()
        coreDataStack.saveContext()
    }
    
    func deleteFakeDiscussions() {
        let request: NSFetchRequest<Discussion> = Discussion.fetchRequest()
        do {
            let fetchResults = try objectContext.fetch(request)
            fetchResults.forEach { objectContext.delete($0) }
        } catch let error as NSError {
            print(error.userInfo)
        }
        coreDataStack.saveContext()
    }
    
    func addFakeMessage(fakeMessage: FakeMessage) -> Message {
        let message = Message(context: objectContext)
        message.content = fakeMessage.content
        message.date = fakeMessage.date
        message.isReceiving = true
        message.isRead = false
        return message
    }
    
    func addMessageToDiscussion(discussion: Discussion, content: String, completionHandler: @escaping (() -> Void)) {
        let message = Message(context: objectContext)
        message.content = content
        message.isReceiving = false
        message.isRead = true
        message.date = Date()
        discussion.date = message.date
        discussion.addToMessages(message)
        coreDataStack.saveContext()
    }
    
    func fetchDiscussions(completionHandler: @escaping (Result<[Discussion], DataStorageError>) -> Void) {
        let request: NSFetchRequest<Discussion> = Discussion.fetchRequest()
        do {
            var fetchResults = try objectContext.fetch(request)
            guard fetchResults.count > 0 else {
                completionHandler(.failure(.noDiscussion))
                return
            }
            fetchResults.sort(by: {$0.date! < $1.date!})
            completionHandler(.success(fetchResults))
        } catch let error {
            print(error)
        }
    }
    
    func fetchDiscussionByUser(named name: String, completionHandler: @escaping (Result<Discussion, DataStorageError>) -> Void) {
        let request: NSFetchRequest<Discussion> = Discussion.fetchRequest()
        request.predicate = NSPredicate(format: "recipient == %@", name)
        do {
            var fetchResults = try objectContext.fetch(request)
            guard fetchResults.count > 0 else {
                completionHandler(.failure(.noDiscussion))
                return
            }
            fetchResults.sort(by: {$0.date! < $1.date!})
            if let disccusion = fetchResults.first {
            completionHandler(.success(disccusion))
            }
        } catch let error {
            print(error)
        }
    }
    
    func fetchMessagesFromDiscussion(recipient: String, completionHandler: @escaping (Result<[Message], DataStorageError>) -> Void) {
        let request: NSFetchRequest<Discussion> = Discussion.fetchRequest()
        request.predicate = NSPredicate(format: "recipient == %@", recipient)
        do {
            let fetchResults = try objectContext.fetch(request)
            guard fetchResults.count > 0 else {
                completionHandler(.failure(.noDiscussion))
                return
            }
            let discussion = fetchResults.first
            let msgArray = discussion?.messages
            var messages: [Message] = msgArray?.compactMap {$0} as! [Message]
            messages.sort(by: {$0.date! < $1.date!})
            completionHandler(.success(messages))
        } catch let error {
            print(error)
        }
    }
}
