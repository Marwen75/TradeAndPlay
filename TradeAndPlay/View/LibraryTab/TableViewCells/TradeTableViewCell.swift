//
//  TradeTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 17/12/2020.
//

import UIKit

class TradeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameOwnedImageView: UIImageView!
    @IBOutlet weak var gameOwnedLabel: UILabel!
    @IBOutlet weak var gameOwnedPlatform: UILabel!
    @IBOutlet weak var gameReceivedImageView: UIImageView!
    @IBOutlet weak var gameReceivedLabel: UILabel!
    @IBOutlet weak var gameReceivedPlatform: UILabel!
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.isHidden = true
        }
    }
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var tradeDateLabel: UILabel!
    @IBOutlet weak var tradeEndDateLabel: UILabel!
    @IBOutlet weak var tradeOverButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(gamOwned: OwnedGame, gameReceived: OwnedGame) {
        
    }
    
}
