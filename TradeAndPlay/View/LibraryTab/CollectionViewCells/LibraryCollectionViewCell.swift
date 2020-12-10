//
//  LibraryCollectionViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 09/12/2020.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    static let id = "LibraryCollectionViewCell"
    
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(platform: String, name: String) {
        platformLabel.text = platform
        gameTitleLabel.text = name
    }
}
