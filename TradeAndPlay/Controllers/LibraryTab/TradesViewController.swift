//
//  TradesViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 17/12/2020.
//

import UIKit

class TradesViewController: UIViewController {
    
    @IBOutlet weak var tradesTableView: UITableView!
    
    var trades: [Trade] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureTableView() {
        
    }
}

extension TradesViewController: UITableViewDelegate {
    
}

extension TradesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
