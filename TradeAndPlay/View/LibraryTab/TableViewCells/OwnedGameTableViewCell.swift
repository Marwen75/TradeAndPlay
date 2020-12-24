//
//  OwnedGameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 18/12/2020.
//

import UIKit

class OwnedGameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var tradeButton: UIButton!
    @IBOutlet weak var tradeLabel: UILabel!
    
    var didTapTrade: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tradeButtonTaped(_ sender: Any) {
        didTapTrade?()
    }
    
    func configure(withOwnedGame game: OwnedGame) {
        nameLabel.text = game.name
        platformLabel.text = game.platform
        let imgId = game.cover
        let stringUrl = "\(ApiConfig.imageUrl)\(imgId ?? "").png"
        gameImageView.load(url: URL(string: stringUrl)!)
    }
    
}
