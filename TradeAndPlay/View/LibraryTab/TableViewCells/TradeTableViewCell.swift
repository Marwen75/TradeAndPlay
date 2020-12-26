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
    
    var didTapTradeOver: (() -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameOwnedImageView.image = nil
        gameOwnedImageView.backgroundColor = .black
    }
    
    @IBAction func tradeOverButtonTaped(_ sender: Any) {
        didTapTradeOver?()
    }
    
    func configure(game: OwnedGame, recipient: String) {
        gameOwnedLabel.text = game.name
        gameOwnedPlatform.text = game.platform
        userLabel.text = recipient
        let imgId = game.cover
        let stringUrl = "\(ApiConfig.imageUrl)\(imgId ?? "").png"
        gameOwnedImageView.load(url: URL(string: stringUrl)!)
        let dateString = game.trade?.beginAt?.formatRelativeString()
        tradeDateLabel.text = dateString
    }
}
