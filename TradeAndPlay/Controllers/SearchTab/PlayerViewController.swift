//
//  PlayerViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 12/12/2020.
//

import UIKit

class PlayerViewController: UIViewController {
    
    
    @IBOutlet weak var playersTableView: UITableView!
    
    var players: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        playersTableView.register(cellType: PlayerTableViewCell.self)
        playersTableView.estimatedRowHeight = 44.0
        playersTableView.rowHeight = UITableView.automaticDimension
    }
    
}

extension PlayerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PlayerTableViewCell {
            cell.bottomView.isHidden = !cell.bottomView.isHidden
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PlayerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if let player = players?[indexPath.row] {
            cell.configure(withUser: player)
        }
        return cell
    }
}
