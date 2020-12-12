//
//  ScreenShotsTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 08/12/2020.
//

import UIKit

class ScreenShotsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var screenShotCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
