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
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var tradeDateLabel: UILabel!
    @IBOutlet weak var tradeOverButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(game: OwnedGame, recipient: String) {
        gameOwnedLabel.text = game.name
        gameOwnedPlatform.text = game.platform
        userLabel.text = recipient
        let imgId = game.cover
        let stringUrl = "\(ApiConfig.imageUrl)\(imgId ?? "").png"
        gameOwnedImageView.load(url: URL(string: stringUrl)!)
        print(game)
        print(recipient)

    }
    
}
