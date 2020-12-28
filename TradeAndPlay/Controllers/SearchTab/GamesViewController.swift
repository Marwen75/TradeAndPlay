//
//  GamesViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit

class GamesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var gamesTableView: UITableView!
    
    // MARK: - Properties
    static let segueId = "listToDetail"
    var games: [GameModel] = []
    var platform: String?
    private var game: GameModel?
    var gameStorage: GameStorage?
    var messageStorage: MessageStorage?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GamesViewController.segueId {
            let gameDetailVC = segue.destination as! GameDetailViewController
            game?.platform = platform ?? ""
            gameDetailVC.game = game
            gameDetailVC.gameStorage = gameStorage
            gameDetailVC.messageStorage = messageStorage
        }
    }
    
    // MARK: - Methods
    private func configureTableView() {
        gamesTableView.sectionHeaderHeight = 70
        gamesTableView.rowHeight = 300
        gamesTableView.register(cellType: GameTableViewCell.self)
    }
    
    private func updateView() {
        let hasGames = games.count > 0
        gamesTableView.isHidden = !hasGames
        //messageLabel.isHidden = hasGames
    }
}

// MARK: - Table view delegate
extension GamesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameToSend = games[indexPath.section]
        self.game = gameToSend
        performSegue(withIdentifier: GamesViewController.segueId, sender: nil)
    }
}

// MARK: - Table view data source
extension GamesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        games.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.headerLabel.text = games[section].name
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GameTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let gameModel = games[indexPath.section]
        cell.configure(withModel: gameModel, platform: platform ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
