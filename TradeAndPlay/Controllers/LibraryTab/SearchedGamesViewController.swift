//
//  SearchedGamesViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 16/12/2020.
//

import UIKit

class SearchedGamesViewController: UIViewController {
    
    @IBOutlet weak var searchedGamesTableView: UITableView!
    
    static let segueId = "searchedToPlayer"
    var searchedGames: [SearchedGame] = []
    var userStorage: UserStorage?
    var gameStorage: GameStorage?
    var fakeUsers: [FakeUser] = FakeUserData.fakeUsers
    var messageStorage: MessageStorage?
    var fetchSearchedGames: (() -> Void)?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fakeUsers = FakeUserData.fakeUsers
        fetchSearchedGames?()
        searchedGamesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSearchedGames?()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SearchedGamesViewController.segueId {
            let playerVC = segue.destination as! PlayerViewController
            playerVC.fakeUsers = fakeUsers
            playerVC.messageStorage = messageStorage
        }
    }
    
    private func configureTableView() {
        searchedGamesTableView.rowHeight = 170
        searchedGamesTableView.register(cellType: SearchedGameTableViewCell.self)
    }
}

extension SearchedGamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let gameName = searchedGames[indexPath.row].name else { return }
        if editingStyle == .delete {
            gameStorage?.deleteFromSearchList(gameNamed: gameName, completionHandler: { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.displayAlert(title: "Done", message: "\(gameName) has been deleted")
            })
            fetchSearchedGames?()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
}

extension SearchedGamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchedGameTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        searchedGames = searchedGames.sorted(by: {$0.platform ?? "" > $1.platform ?? ""})
        cell.configure(withSearchedGame: searchedGames[indexPath.row])
        let gameName = searchedGames[indexPath.row].name
        var gameOwners = [FakeUser]()
        for fakeUser in fakeUsers {
            for game in fakeUser.ownedGamesList {
                if game.name == gameName {
                    gameOwners.append(fakeUser)
                }
            }
        }
        if gameOwners.count > 0 {
            cell.noUserFoundLabel.isHidden = true
            cell.whoHasItButton.isHidden = false
            cell.didTapWho = { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.fakeUsers = gameOwners
                strongSelf.performSegue(withIdentifier: SearchedGamesViewController.segueId, sender: nil)
            }
        } else {
            cell.noUserFoundLabel.isHidden = false
            cell.whoHasItButton.isHidden = true
        }
        return cell
    }
}
