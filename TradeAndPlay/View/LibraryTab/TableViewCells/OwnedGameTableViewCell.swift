//
//  OwnedGameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 18/12/2020.
//

import UIKit

class OwnedGameTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var tradeButton: UIButton!
    @IBOutlet weak var tradeLabel: UILabel!
    
    // MARK: - Properties
    var didTapTrade: (() -> Void)?
    
    // MARK: - View life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.image = nil
        gameImageView.backgroundColor = .black
    }
    
    // MARK: - Actions
    @IBAction func tradeButtonTaped(_ sender: Any) {
        didTapTrade?()
    }
    
    // MARK: - Methods
    func configure(withOwnedGame game: OwnedGame) {
        nameLabel.text = game.name
        platformLabel.text = game.platform
        let imgId = game.cover
        let stringUrl = "\(ApiConfig.imageUrl)\(imgId ?? "").png"
        gameImageView.load(url: URL(string: stringUrl)!)
    }
    
}
