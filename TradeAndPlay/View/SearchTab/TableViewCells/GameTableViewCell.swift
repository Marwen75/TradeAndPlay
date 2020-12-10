//
//  GameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    static let id = "GameTableViewCell"
        
    @IBOutlet weak var gameImageView: UIImageView!
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
    func configure(release: String, genres: String, platformCount: String, rating: String) {
        ratingLabel.text = "Rating: \(rating)/100"
        releaseLabel.text = release
        genreLabel.text = "Genres: \(genres)"
        platformLabel.text = "Available on \(platformCount) platform(s)."
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
