//
//  LibraryViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 16/12/2020.
//

import UIKit

class LibraryViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tradesVc: UIView!
    @IBOutlet weak var ownedVc: UIView!
    @IBOutlet weak var searchVc: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var messageButton: UIBarButtonItem!
    
    // MARK: - Properties
    var gameStorage: GameStorage?
    var messageStorage: MessageStorage?
    var searchedGames: [SearchedGame] = []
    var ownedGames: [OwnedGame] = []
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchVc.isHidden = true
        self.tradesVc.isHidden = true
        if #available(iOS 13, *) {
            //Keep our segmented control as it is
        } else {
            segment.backgroundColor = UIColor(named: "DarkBlue")
            segment.tintColor = UIColor(named: "Sand")
        }
        
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
            }
        case "toTrade":
            if let tradeVC = segue.destination as? TradesViewController {
                tradeVC.fetchCurrentTrades = { [weak self] in
                    guard let strongSelf = self else {return}
                    strongSelf.gameStorage?.fetchCurrentTrades(completionHandler: { result in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let ownedGames):
                            tradeVC.ownedGamesTraded = ownedGames
                            tradeVC.gameStorage = strongSelf.gameStorage
                        }
                    })
                }
            }
        case "toMessage":
            if let conversationsVC = segue.destination as? ConversationsViewController {
                conversationsVC.messageStorage = self.messageStorage
            }
        default:
            print("def")
        }
    }
    
    // MARK: - Actions
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
