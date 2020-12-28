//
//  GameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit

class GameTableViewCell: UITableViewCell {
       
    // MARK: - Outlets
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    // MARK: - View life cycle
    override func prepareForReuse() {
        super .prepareForReuse()
        gameImageView.image = nil
        gameImageView.backgroundColor = .black
    }
    
    // MARK: - Methods
    func configure(withModel model: GameModel, platform: String) {
        let imgId = model.cover
        gameImageView.load(url: URL(string: "\(ApiConfig.imageUrl)\(imgId ).png")!)
        let rating = Int(round(model.rating))
        ratingLabel.text = "Rated: \(rating)/100"
        releaseLabel.text = "First released: \(configureDate(model: model))"
        genreLabel.text = "Genres: \(model.genres.joined(separator: ", "))"
        platformLabel.text = platform
    }
}
