//
//  SearchedGamesViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 16/12/2020.
//

import UIKit

class SearchedGamesViewController: UIViewController {
    
    @IBOutlet weak var searchedGamesTableView: UITableView!
    
    var searchedGames: [SearchedGame] = []
    var userStorage: UserStorage?
    var gameStorage: GameStorage?
    var users: [User] = []
    var fetchSearchedGames: (() -> Void)?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSearchedGames?()
        searchedGamesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSearchedGames?()
        configureTableView()
    }
    
    private func configureTableView() {
        searchedGamesTableView.rowHeight = 180
        searchedGamesTableView.register(cellType: SearchedGameTableViewCell.self)
    }
    
    private func sortPlatforms(searchedGames: [SearchedGame]) -> [String] {
        var platforms: [String] = []
        searchedGames.forEach { game in
            platforms.append(game.platform!)
        }
        let platformCount = Array(Set(platforms))
        return platformCount
    }
}

extension SearchedGamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let gameName = searchedGames[indexPath.row].name else { return }
        if editingStyle == .delete {
            gameStorage?.deleteFromSearchList(gameNamed: gameName, completionHandler: {
            [weak self] in
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
        userStorage?.fetchUsersWhoHasGame(named: searchedGames[indexPath.row].name ?? "", completionHandler: { [weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                cell.noUserFoundLabel.isHidden = false
                cell.whoHasItButton.isHidden = true
                print(error)
            case .success(let users):
                cell.noUserFoundLabel.isHidden = true
                cell.whoHasItButton.isHidden = false
                strongSelf.users = users
            }
        })
        return cell
    }
}
