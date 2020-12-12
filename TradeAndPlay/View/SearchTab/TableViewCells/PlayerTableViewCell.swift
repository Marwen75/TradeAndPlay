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
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.isHidden = true
        }
    }
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var tradeLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func contactButtonTaped(_ sender: Any) {
    }
    
    @IBAction func libraryButtonTaped(_ sender: Any) {
    }
    
    func configure(withUser user: User) {
        nickNameLabel.text = user.nickname
        cityLabel.text = "City: \(String(user.city ?? "N/A"))"
        ratingLabel.text = "Rated \(String(user.rating))/100 by other traders."
    }
}
