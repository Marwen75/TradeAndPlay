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
        libraryVc?.messageStorage = MessageStorage(coreDataStack: coreDataStack)
        libraryVc?.messageStorage?.deleteFakeDiscussions()
        libraryVc?.messageStorage?.addFakeDiscussion(fakeUser: FakeUserData.fakeUsers[0])
        libraryVc?.messageStorage?.addFakeDiscussion(fakeUser: FakeUserData.fakeUsers[1])
        libraryVc?.messageStorage?.addFakeDiscussion(fakeUser: FakeUserData.fakeUsers[2])
        libraryVc?.messageStorage?.addFakeDiscussion(fakeUser: FakeUserData.fakeUsers[3])
        searchVc!.gameStorage = GameStorage(coreDataStack: coreDataStack)
        searchVc!.messageStorage = MessageStorage(coreDataStack: coreDataStack)
        searchVc!.igdbService = IgdbService(session: session)
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
