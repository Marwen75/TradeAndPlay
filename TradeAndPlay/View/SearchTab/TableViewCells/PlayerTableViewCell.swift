//
//  PlayerTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 12/12/2020.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var didTapContact: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func contactButtonTaped(_ sender: Any) {
        didTapContact?()
    }
    
    
    func configure(withUser user: FakeUser) {
        nickNameLabel.text = user.nickName
        cityLabel.text = "City: \(String(user.city))"
    }
}
