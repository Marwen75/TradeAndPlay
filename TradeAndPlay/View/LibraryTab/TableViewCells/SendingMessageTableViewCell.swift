//
//  SendingMessageTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 19/12/2020.
//

import UIKit

class SendingMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func configure(message: Message) {
        messageLabel.text = message.content
        let dateString = message.date?.formatRelativeString()
        timeLabel.text = dateString
    }
    
}
