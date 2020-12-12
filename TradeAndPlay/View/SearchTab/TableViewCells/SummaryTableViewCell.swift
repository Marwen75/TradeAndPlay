//
//  SummaryTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 08/12/2020.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var summaryLabel: RoundLabel!
    
    func configure(withModel model: GameModel) {
        summaryLabel.text = model.summary
    }
    
}
