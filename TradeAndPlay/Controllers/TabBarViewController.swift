//
//  TabBarViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit

// Our tab bar viewcontroller where we will initialize coredata and URLSession
class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = URLSession(configuration: .default)
        let searchVc = self.children[0].children[0] as? SearchViewController
        let libraryVc = self.children[1].children[0] as? LibraryViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = appDelegate.coreDataStack
        libraryVc!.gameStorage = GameStorage(coreDataStack: coreDataStack)
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
