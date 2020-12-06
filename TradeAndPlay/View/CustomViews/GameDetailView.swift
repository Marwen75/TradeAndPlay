//
//  GameDetailView.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 05/12/2020.
//

import UIKit
@IBDesignable
class GameDetailView: NibView {
    
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var storyLineLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var platformsPickerView: UIPickerView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    @IBOutlet weak var ratingStarsImageView: UIImageView!
}
