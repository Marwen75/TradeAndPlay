//
//  GamesViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit

class GamesViewController: UIViewController {
    
    static let segueId = "listToDetail"
    var games: [Game] = []
    private var game: Game?
    
    @IBOutlet weak var gamesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GamesViewController.segueId {
            let gameDetailVC = segue.destination as! GameDetailViewController
            gameDetailVC.game = game
        }
    }
    
    
    // MARK: - Methods
    private func configureTableView() {
        gamesTableView.sectionHeaderHeight = 60
        gamesTableView.rowHeight = 400
        gamesTableView.register(UINib(nibName: GameTableViewCell.id, bundle: nil), forCellReuseIdentifier: GameTableViewCell.id)
    }
}


// MARK: - Table view delegate
extension GamesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameToSend = games[indexPath.section]
        self.game = gameToSend
        print(gameToSend.name)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.id, for: indexPath) as? GameTableViewCell else {
            return UITableViewCell()
        }
        
        let imgId = games[indexPath.section].cover?.image_id
        
        cell.gameImageView.load(url: URL(string: "\(ApiConfig.imageUrl)\(imgId ?? "coluje").png")!)
        
        var genreNames = [String]()
        games[indexPath.row].genres?.forEach { genreNames.append($0.name) }
        
        var platforms = [String]()
        games[indexPath.section].platforms?.forEach { platforms.append($0.name) }
        
        cell.configure(release: configureDate(game: games[indexPath.section]), genres: genreNames.joined(separator: ", "), platformCount: "\(platforms.count)", rating: String(round(games[indexPath.section].rating ?? 0)))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
