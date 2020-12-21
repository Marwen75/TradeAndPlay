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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(message: Message) {
        messageLabel.text = message.content
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: Date())
        timeLabel.text = dateString
    }
    
}
