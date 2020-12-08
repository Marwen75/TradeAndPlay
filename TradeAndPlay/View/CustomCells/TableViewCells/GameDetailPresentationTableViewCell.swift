//
//  GameDetailPresentationTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 08/12/2020.
//

import UIKit

class GameDetailPresentationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: RoundLabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    
    func configure(title: String, genres: String, release: String, ratings: String) {
        titleLabel.text = title
        genreLabel.text = genres
        releaseLabel.text = release
        ratingsLabel.text = ratings
    }
}
