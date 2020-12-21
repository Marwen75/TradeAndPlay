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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func whoHasItButtonTaped(_ sender: Any) {
    }
    
    func configure(withSearchedGame game: SearchedGame) {
        nameLabel.text = game.name
        platformLabel.text = game.platform
        let imgId = game.cover
        let stringUrl = "\(ApiConfig.imageUrl)\(imgId ?? "").png"
        gameImageView.load(url: URL(string: stringUrl)!)
    }
    
}
