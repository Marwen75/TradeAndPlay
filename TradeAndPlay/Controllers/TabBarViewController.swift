//
//  TabBarViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(children[0].children)
        let session = URLSession(configuration: .default)
        let searchVc = self.children[0].children[0] as? SearchViewController
        let libraryVc = self.children[1].children[0] as? LibraryViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = appDelegate.coreDataStack
        searchVc!.dataStorage = DataStorage(coreDataStack: coreDataStack)
        searchVc!.igdbService = IgdbService(session: session)
        libraryVc!.dataStorage = DataStorage(coreDataStack: coreDataStack)
       // searchVc?.dataStorage?.deleteFakeUsers()
        //searchVc?.dataStorage?.deleteGame()
       // searchVc?.dataStorage?.addFakeUser(name: "Toto", city: "Paris", rating: 97)
       // searchVc?.dataStorage?.addFakeUser(name: "Max", city: "Melun", rating: 100)
       // searchVc?.dataStorage?.addFakeUser(name: "Eve", city: "Boulogne", rating: 82)
       // searchVc?.dataStorage?.addFakeUser(name: "Frea", city: "Creteil", rating: 17)
       // searchVc?.dataStorage?.addFakeUser(name: "Jim", city: "Alfortville", rating: 46)
    }
}

