//
//  TradesViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 17/12/2020.
//

import UIKit

class TradesViewController: UIViewController {
    
    @IBOutlet weak var tradesTableView: UITableView!
    
    var ownedGamesTraded: [OwnedGame] = []
    var gameStorage: GameStorage?
    var fetchTrades: (() -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTrades?()
        tradesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tradesTableView.estimatedRowHeight = 44
        tradesTableView.rowHeight = UITableView.automaticDimension
        tradesTableView.register(cellType: TradeTableViewCell.self)
    }
}

extension TradesViewController: UITableViewDelegate {
    
}

extension TradesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ownedGamesTraded.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tradeCell: TradeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        print(ownedGamesTraded.forEach({$0.trade?.recipient}))
        let recipient = ownedGamesTraded[indexPath.row].trade?.recipient ?? "Jojo"
        tradeCell.configure(game: ownedGamesTraded[indexPath.row], recipient: recipient)
        return tradeCell
    }
}

