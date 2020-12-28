//
//  GameDetailPresentationTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 08/12/2020.
//

import UIKit

class GameDetailPresentationTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    
    // MARK: - Methods
    func configure(withModel model: GameModel) {
        genreLabel.text = model.genres.joined(separator: ", ")
        releaseLabel.text = "First released: \(configureDate(model: model))"
        let rating = Int(round(model.rating))
        ratingsLabel.text = "Rated: \(rating)/100"
    }
}
