//
//  SummaryTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 08/12/2020.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    func configure(withModel model: GameModel) {
        summaryLabel.text = model.summary
    }
    
}
