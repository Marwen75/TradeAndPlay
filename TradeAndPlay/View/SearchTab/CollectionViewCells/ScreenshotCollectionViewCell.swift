//
//  ScreenshotCollectionViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 06/12/2020.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        screenshotImageView.image = nil
        screenshotImageView.backgroundColor = .black
    }
}
