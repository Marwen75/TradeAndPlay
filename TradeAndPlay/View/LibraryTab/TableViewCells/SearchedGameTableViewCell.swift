//
//  SearchedGameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 18/12/2020.
//

import UIKit

class SearchedGameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var whoHasItButton: UIButton!
    @IBOutlet weak var noUserFoundLabel: UILabel!
    
    var didTapWho: (() -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.image = nil
        gameImageView.backgroundColor = .black
    }
    
    @IBAction func whoHasItButtonTaped(_ sender: Any) {
        didTapWho?()
    }
    
    func configure(withSearchedGame game: SearchedGame) {
        nameLabel.text = game.name
        platformLabel.text = game.platform
        let imgId = game.cover
        let stringUrl = "\(ApiConfig.imageUrl)\(imgId ?? "").png"
        gameImageView.load(url: URL(string: stringUrl)!)
    }
    
}
