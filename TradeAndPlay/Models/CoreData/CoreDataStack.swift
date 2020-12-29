//
//  CoreDataStack.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 09/12/2020.
//

import Foundation
import CoreData
// An object that will manage the core data stack and saving support
class CoreDataStack {
    
    // MARK: - Properties
    static let modelName = "TradeAndPlay"
    
    init() {
    }
    
    
    static let managedObjectModel: NSManagedObjectModel = {
       let modelURL = Bundle.main.url(forResource: CoreDataStack.modelName, withExtension: "momd")!
       return NSManagedObjectModel(contentsOf: modelURL)!
     }()
   
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.managedObjectModel)
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
    func saveContext() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch let nserror as NSError {
            print(nserror.userInfo)
        }
    }
}
