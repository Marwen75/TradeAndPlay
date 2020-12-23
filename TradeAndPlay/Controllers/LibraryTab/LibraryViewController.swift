//
//  LibraryViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 16/12/2020.
//

import UIKit

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var tradesVc: UIView!
    @IBOutlet weak var ownedVc: UIView!
    @IBOutlet weak var searchVc: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var messageButton: UIBarButtonItem!
    
    var gameStorage: GameStorage?
    var userStorage: UserStorage?
    var messageStorage: MessageStorage?
    var searchedGames: [SearchedGame] = []
    var ownedGames: [OwnedGame] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchVc.isHidden = true
        self.tradesVc.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toOwned":
            if let ownedVC = segue.destination as? OwnedGamesViewController {
                ownedVC.fetchOwnedGames = { [weak self] in
                    guard let strongSelf = self else {return}
                    strongSelf.gameStorage?.fetchOwnedGames(completionHandler: { result in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let ownedGames):
                            ownedVC.ownedGames = ownedGames
                        }
                    })
                }
                ownedVC.gameStorage = self.gameStorage
            }
        case "toSearch":
            if let searchVC = segue.destination as? SearchedGamesViewController {
                searchVC.fetchSearchedGames = { [weak self] in
                    guard let strongSelf = self else {return}
                    strongSelf.gameStorage?.fetchSearchedGames(completionHandler: { result in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let searchedGames):
                            searchVC.searchedGames = searchedGames
                            searchVC.messageStorage = strongSelf.messageStorage
                        }
                    })
                }
                searchVC.gameStorage = self.gameStorage
                searchVC.userStorage = self.userStorage
            }
        case "toTrade":
            print("totrade")
        case "toMessage":
            if let conversationsVC = segue.destination as? ConversationsViewController {
                conversationsVC.messageStorage = self.messageStorage
            }
        default:
            print("def")
        }
    }
    
    @IBAction func segmentTaped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            ownedVc.isHidden = false
            searchVc.isHidden = true
            tradesVc.isHidden = true
        case 1:
            ownedVc.isHidden = true
            tradesVc.isHidden = true
            searchVc.isHidden = false
        case 2:
            tradesVc.isHidden = false
            ownedVc.isHidden = true
            searchVc.isHidden = true
        default:
            print("default")
        }
    }
    
    @IBAction func messageButtonTaped(_ sender: Any) {
        performSegue(withIdentifier: "toMessage", sender: nil)
    }
    
}
