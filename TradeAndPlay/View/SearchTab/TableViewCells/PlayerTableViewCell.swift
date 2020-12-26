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

    @IBAction func contactButtonTaped(_ sender: Any) {
        didTapContact?()
    }
    
    func configure(withUser user: FakeUser) {
        nickNameLabel.text = user.nickName
        cityLabel.text = "City: \(String(user.city))"
    }
}
