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
        gamesTableView.rowHeight = 400
        gamesTableView.register(UINib(nibName: GameTableViewCell.id, bundle: nil), forCellReuseIdentifier: GameTableViewCell.id)
    }
}


// MARK: - Table view delegate
extension GamesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameToSend = games[indexPath.row]
        self.game = gameToSend
        print(gameToSend.name)
        performSegue(withIdentifier: GamesViewController.segueId, sender: nil)
    }
}

// MARK: - Table view data source
extension GamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.id, for: indexPath) as? GameTableViewCell else {
            return UITableViewCell()
        }
        
        let imgId = games[indexPath.row].cover?.image_id
        
        cell.gameImageView.load(url: URL(string: "\(ApiKey.imageUrl)\(imgId ?? "coluje").png")!)
        
        // https://images.igdb.com/igdb/image/upload/t_cover_big/co1uje.png
        /*let date = Date(timeIntervalSince1970: TimeInterval(games[indexPath.row].first_release_date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)*/
        
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor(named: "TradeAndPlay")?.cgColor
        
        var genreNames = [String]()
        games[indexPath.row].genres?.forEach { genreNames.append($0.name) }
        
        var platforms = [String]()
        games[indexPath.row].platforms?.forEach { platforms.append($0.name) }
        
        cell.configure(name: (games[indexPath.row].name), release: "", genres: genreNames.joined(separator: ", "), platform: platforms.joined(separator: ", "), rating: String(round(games[indexPath.row].rating ?? 0)))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}
