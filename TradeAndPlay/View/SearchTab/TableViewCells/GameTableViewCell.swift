//
//  GameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit

class GameTableViewCell: UITableViewCell {
        
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
    func configure(withModel model: GameModel) {
        let imgId = model.cover
        gameImageView.load(url: URL(string: "\(ApiConfig.imageUrl)\(imgId ).png")!)
        let rating = Int(round(model.rating))
        ratingLabel.text = "Rated: \(rating)/100"
        releaseLabel.text = "First released: \(configureDate(model: model))"
        genreLabel.text = "Genres: \(model.genres.joined(separator: ", "))"
        guard let count = model.platforms?.count else {return}
        platformLabel.text = "Available on \(count) platform(s)."
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
