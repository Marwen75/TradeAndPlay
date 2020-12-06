//
//  GameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit

class GameTableViewCell: UITableViewCell {
        
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    override func prepareForReuse() {
        super .prepareForReuse()
        gameImageView.image = nil
        gameImageView.backgroundColor = .black
    }
    // func that will alow us to configure the cell
    func configure(name: String, release: String, genres: String, platform: String, rating: String) {
        titleLabel.text = name
        ratingLabel.text = rating == "0.0" ? "N/A" : "Rating: \(rating)%"
        releaseLabel.text = "First released \(release)"
        genreLabel.text = "Genres: \(genres)"
        platformLabel.text = "Platforms: \(platform)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
