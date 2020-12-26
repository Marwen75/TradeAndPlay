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
    
    
    func configure(discussion: Discussion) {
        nickNameLabel.text = discussion.recipient
        let messagesArray = discussion.messages?.allObjects
        var messages: [Message] = messagesArray?.compactMap {$0} as! [Message]
        messages.sort(by: {$0.date! < $1.date!})
        messageLabel.text = messages.last?.content
        let dateString = messages.last?.date?.formatRelativeString()
        dateLabel.text = dateString
    }
    
}
