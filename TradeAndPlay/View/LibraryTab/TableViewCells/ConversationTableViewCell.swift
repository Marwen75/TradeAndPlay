//
//  ConversationTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 19/12/2020.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(discussion: Discussion) {
        nickNameLabel.text = discussion.recipient
        let messagesArray = discussion.messages?.allObjects
        var messages: [Message] = messagesArray?.compactMap {$0} as! [Message]
        messages.sort(by: {$0.date! < $1.date!})
        messageLabel.text = messages.last?.content
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: (messages.last?.date)!)
        dateLabel.text = dateString
    }
    
}
