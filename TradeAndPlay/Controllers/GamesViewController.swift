//
//  GamesViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit
import IGDB_SWIFT_API

class GamesViewController: UIViewController {
    
    static let segueId = "listToDetail"
    var games: [Proto_Game] = []
    private var game: Proto_Game?
    
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
        gamesTableView.rowHeight = 350
        gamesTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as? GameTableViewCell else {
            return UITableViewCell()
        }
        
        let image_id = games[indexPath.row].cover.imageID
        let imageURL = imageBuilder(imageID: image_id, size: .COVER_BIG, imageType: .PNG)
        
        cell.gameImageView.load(url: URL(string: imageURL)!)
        
        let date = Date(timeIntervalSince1970: TimeInterval(games[indexPath.row].firstReleaseDate.seconds))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        
        var genreNames = [String]()
        games[indexPath.row].genres.forEach { genreNames.append($0.name) }
        
        var platforms = [String]()
        games[indexPath.row].platforms.forEach { platforms.append($0.name) }
        
        cell.configure(name: (games[indexPath.row].name), release: strDate, genres: genreNames.joined(separator: ", "), platform: platforms.joined(separator: ", "), rating: String(round(games[indexPath.row].rating)))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}