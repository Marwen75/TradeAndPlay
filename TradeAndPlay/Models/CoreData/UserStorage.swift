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
        request.predicate = NSPredicate(format: "nickName == %@", name)
        guard let fetchResults = try? objectContext.fetch(request), fetchResults.count > 0 else {
            completionHandler(.failure(.noPlayerFound))
            return
        }
        completionHandler(.success(fetchResults))
    }
}


