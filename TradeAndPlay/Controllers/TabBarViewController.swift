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
        let session = URLSession(configuration: .default)
        let searchVc = self.children[0].children[0] as? SearchViewController
        let libraryVc = self.children[1].children[0] as? LibraryViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = appDelegate.coreDataStack
        libraryVc!.gameStorage = GameStorage(coreDataStack: coreDataStack)
        libraryVc!.userStorage = UserStorage(coreDataStack: coreDataStack)
        searchVc!.gameStorage = GameStorage(coreDataStack: coreDataStack)
        searchVc!.dummyUserStorage = UserStorage(coreDataStack: coreDataStack)
        searchVc!.userStorage = UserStorage(coreDataStack: coreDataStack)
        searchVc!.igdbService = IgdbService(session: session)
        searchVc?.dummyUserStorage?.deleteFakeUsers()
        
        
        
        //searchVc?.userStorage?.deleteGame()
        //searchVc?.userStorage?.addFakeUser(name: "Toto", city: "Paris", rating: 97)
       // searchVc?.dataStorage?.addFakeUser(name: "Max", city: "Melun", rating: 100)
       // searchVc?.dataStorage?.addFakeUser(name: "Eve", city: "Boulogne", rating: 82)
       // searchVc?.dataStorage?.addFakeUser(name: "Frea", city: "Creteil", rating: 17)
       // searchVc?.dataStorage?.addFakeUser(name: "Jim", city: "Alfortville", rating: 46)
    }
}

/*Optional("co1wyy")
Optional("The Witcher 3: Wild Hunt")
Optional("PlayStation 4")
Optional("co1tmu")
Optional("God of War")
Optional("PlayStation 4")
Optional("co2gu4")
Optional("Hagane: The Final Conflict")
Optional("Super Nintendo Entertainment System (SNES)")
Optional("co23jy")
Optional("Super Mario World")
Optional("Super Nintendo Entertainment System (SNES)")
Optional("co25w2")
Optional("Demon\'s Crest")
Optional("Super Nintendo Entertainment System (SNES)")
Optional("co2a23")
Optional("Sekiro: Shadows Die Twice")
Optional("PlayStation 4")
Optional("co1yad")
Optional("Shenmue")
Optional("Dreamcast")
*/
