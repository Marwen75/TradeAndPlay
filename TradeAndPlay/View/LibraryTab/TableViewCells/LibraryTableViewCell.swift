//
//  LibraryTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 09/12/2020.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var libraryCollectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
