//
//  PlayerTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 12/12/2020.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    // MARK: - Properties
    var didTapContact: (() -> Void)?
    
    // MARK: - Actions
    @IBAction func contactButtonTaped(_ sender: Any) {
        didTapContact?()
    }
    
    // MARK: - Methods
    func configure(withUser user: FakeUser) {
        nickNameLabel.text = user.nickName
        cityLabel.text = "City: \(String(user.city))"
    }
}
