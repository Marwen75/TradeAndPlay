//
//  TestCoreDataStack.swift
//  TradeAndPlayTests
//
//  Created by Marwen Haouacine on 26/12/2020.
//

import XCTest
@testable import TradeAndPlay
import CoreData

// A class that inherits from CoreDataStack that will serve within our tests
class TestCoreDataStack: CoreDataStack {

    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: CoreDataStack.modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores {_, error in
            if let error = error as NSError? {
                fatalError("\(error)")
            }
        }
        persistentContainer = container
    }
}
