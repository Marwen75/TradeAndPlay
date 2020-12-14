//
//  GamesViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit

class GamesViewController: UIViewController {
    
    static let segueId = "listToDetail"
    var games: [GameModel] = []
    private var game: GameModel?
    var dataStorage: DataStorage?
    
    @IBOutlet weak var gamesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GamesViewController.segueId {
            let gameDetailVC = segue.destination as! GameDetailViewController
            gameDetailVC.game = game
            gameDetailVC.dataStorage = dataStorage
        }
    }
    
    // MARK: - Methods
    private func configureTableView() {
        gamesTableView.sectionHeaderHeight = 70
        gamesTableView.rowHeight = 350
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
        cell.configure(withModel: gameModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
