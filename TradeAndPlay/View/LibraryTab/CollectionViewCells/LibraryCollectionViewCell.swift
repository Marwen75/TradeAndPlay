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
    
    var didTapDelete: (() -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.image = nil
        gameImageView.backgroundColor = .black
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func deleteButtonTaped(_ sender: Any) {
        didTapDelete?()
    }
    
    
    func configure(whitStoredGame storedGame: StoredGame) {
        let imgId = storedGame.cover
        let url = "\(ApiConfig.imageUrl)\(imgId ?? "coluche").png"
        gameImageView.load(url: URL(string: url)!)
        platformLabel.text = storedGame.platform
        gameTitleLabel.text = storedGame.name
    }
}
