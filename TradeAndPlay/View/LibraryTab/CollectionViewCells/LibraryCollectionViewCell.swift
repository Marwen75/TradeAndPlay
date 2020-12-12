//
//  LibraryCollectionViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 09/12/2020.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func deleteButtonTaped(_ sender: Any) {
    }
    
    
    func configure(whitStoredGame storedGame: StoredGame) {
        let imgId = storedGame.cover
        let url = "\(ApiConfig.imageSmallUrl)\(imgId ?? "coluche").png"
        print(url)
        gameImageView.load(url: URL(string: url)!)
        platformLabel.text = storedGame.platform
        gameTitleLabel.text = storedGame.name
    }
}
