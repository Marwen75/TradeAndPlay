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
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(sender: String) {
        nickNameLabel.text = sender
       // messageLabel.text = discussion.messages.last?.content
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        //let dateString = formatter.string(from: (conversation.last?.date!)!)
        dateLabel.text = ""
    }
    
}
