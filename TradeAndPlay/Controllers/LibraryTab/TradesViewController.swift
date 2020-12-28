//
//  TradesViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 17/12/2020.
//

import UIKit

class TradesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tradesTableView: UITableView!
    
    // MARK: - Outlets
    var ownedGamesTraded: [OwnedGame] = []
    var gameStorage: GameStorage?
    var fetchCurrentTrades: (() -> Void)?
    
    // MARK: - View life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCurrentTrades?()
        tradesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Methods
    private func configureTableView() {
        tradesTableView.estimatedRowHeight = 44
        tradesTableView.rowHeight = UITableView.automaticDimension
        tradesTableView.register(cellType: TradeTableViewCell.self)
    }
}

// MARK: - Table View Delegate
extension TradesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.headerLabel.text = "You don't have any current Trades."
        return header
    }
}

// MARK: - Table view Data Source
extension TradesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ownedGamesTraded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tradeCell: TradeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let game = ownedGamesTraded[indexPath.row]
        let recipient = game.trade?.recipient ?? "Jojo"
        tradeCell.configure(game: game, recipient: recipient)
        tradeCell.didTapTradeOver = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.gameStorage?.deleteTrade(game: game)
            strongSelf.displayAlert(title: "Done", message: "Your trade \(game.name ?? "") with \(recipient) is now considered over !")
            strongSelf.ownedGamesTraded.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return tradeCell
    }
    // setting the height for our header that displays the message
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ownedGamesTraded.isEmpty ? tableView.frame.size.height : 0
    }
}

