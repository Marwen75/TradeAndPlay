//
//  SummaryTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 08/12/2020.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    static let id = "SummaryTableViewCell"
    
    @IBOutlet weak var summaryLabel: RoundLabel!
    
    func configure(summary: String) {
        summaryLabel.text = summary
    }
    
}
