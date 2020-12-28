//
//  ScreenshotCollectionViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 06/12/2020.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    // MARK: - View life cycle
    override func prepareForReuse() {
        super .prepareForReuse()
        screenshotImageView.image = nil
        screenshotImageView.backgroundColor = .black
    }
}
