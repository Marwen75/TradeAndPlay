//
//  CoreDataStack.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 09/12/2020.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Properties
    static let modelName = "TradeAndPlay"
    
    init() {
    }
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: CoreDataStack.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.userInfo)
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        guard viewContext.hasChanges else { return }
        
        do {
            try viewContext.save()
        } catch let nserror as NSError {
            print(nserror.userInfo)
        }
    }
}
