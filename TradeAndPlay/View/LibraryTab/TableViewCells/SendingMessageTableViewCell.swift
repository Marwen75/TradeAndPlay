//
//  SendingMessageTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 19/12/2020.
//

import UIKit

// Our custom sending message table view cell
class SendingMessageTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Methods
    func configure(message: Message) {
        messageLabel.text = message.content
        let dateString = message.date?.formatRelativeString()
        timeLabel.text = dateString
    }
    
}
