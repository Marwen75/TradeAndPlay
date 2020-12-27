//
//  OwnedGamesViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 16/12/2020.
//

import UIKit

class OwnedGamesViewController: UIViewController {
    
    @IBOutlet weak var ownedGamesTableView: UITableView!
    
    static let segueId = "ownedToForm"
    var ownedGames: [OwnedGame] = []
    var ownedGame: OwnedGame?
    var gameStorage: GameStorage?
    var messageStorage: MessageStorage?
    var fetchOwnedGames: (() -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchOwnedGames?()
        ownedGamesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == OwnedGamesViewController.segueId {
            let formVC = segue.destination as! TradeFormViewController
            formVC.ownedGame = ownedGame
            formVC.gameStorage = gameStorage
        }
    }
    
    private func configureTableView() {
        ownedGamesTableView.rowHeight = 170
        ownedGamesTableView.register(cellType: OwnedGameTableViewCell.self)
    }
}

extension OwnedGamesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let gameName = ownedGames[indexPath.row].name else { return }
        if ownedGames[indexPath.row].isTraded == false {
            if editingStyle == .delete {
                gameStorage?.deleteFromOwnedList(gameNamed: gameName, completionHandler: {
                    [weak self] in
                    guard let strongSelf = self else {return}
                    strongSelf.displayAlert(title: "Done", message: "\(gameName) has been deleted")
                })
                fetchOwnedGames?()
                tableView.deleteRows(at: [indexPath], with: .middle)
            }
            tableView.reloadData()
        }
    }
}

extension OwnedGamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ownedGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: OwnedGameTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        ownedGames = ownedGames.sorted(by: { $0.platform ?? ""  > $1.platform ?? "" })
        cell.configure(withOwnedGame: ownedGames[indexPath.row])
        if ownedGames[indexPath.row].isTraded == false {
            cell.tradeButton.isHidden = false
            cell.tradeLabel.isHidden = true
            cell.backgroundColor = UIColor(named: "Sand")
        } else {
            cell.tradeButton.isHidden = true
            cell.tradeLabel.isHidden = false
            cell.backgroundColor = .gray
        }
        cell.didTapTrade = {[weak self] in
            guard let strongSelf = self else {return}
            strongSelf.ownedGame = strongSelf.ownedGames[indexPath.row]
            strongSelf.performSegue(withIdentifier: OwnedGamesViewController.segueId, sender: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.headerLabel.text = "You don't have any games in \n your owned game list.\n Find the correct versions of your games \n by using the search tab to fill your list."
        return header
    }
    // setting the height for our header that displays the message
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ownedGames.isEmpty ? tableView.frame.size.height : 0
    }
}
