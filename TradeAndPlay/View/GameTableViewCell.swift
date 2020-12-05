//
//  GameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    private let oneStarImage = UIImage(named: "etoile1")
    private let twoStarImage = UIImage(named: "etoile2")
    private let threeStarImage = UIImage(named: "etoile3")
    private let fourStarImage = UIImage(named: "etoile4")
    private let fiveStarImage = UIImage(named: "etoile5")
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingStarsImageView: UIImageView!
    
    
    override func prepareForReuse() {
        super .prepareForReuse()
        gameImageView.image = nil
        gameImageView.backgroundColor = .black
    }
    // func that will alow us to configure the cell
    func configure(name: String, summary: String, rating: String) {
        titleLabel.text = name
        ratingLabel.text = rating == "0.0" ? "N/A" : "Note: \(rating)%"
        descriptionLabel.text = summary
        ratingStarsImageView.image = configureRatings(rating: Double(rating) ?? 0)
    }
    
    private func configureRatings(rating: Double) -> UIImage {
        if rating <= 20 {
            return oneStarImage!
        } else if rating > 20 && rating < 40 {
            return twoStarImage!
        } else if rating > 40 && rating < 70 {
            return threeStarImage!
        } else if rating > 70 && rating < 85 {
            return fourStarImage!
        } else {
            return fiveStarImage!
        }
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
