//
//  AddGameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 09/12/2020.
//

import UIKit

class AddGameTableViewCell: UITableViewCell {

    @IBOutlet weak var seeWhoButton: RoundButton!
    @IBOutlet weak var addToLibraryButton: RoundButton!
    @IBOutlet weak var addToSearchListButton: RoundButton!
    
    var didTapSeeWho: (() -> Void)?
    var didTapAdd: (() -> Void)?
    var didTapAddToSearch: (() -> Void)?
    
    @IBAction func seeWhoButtonTaped(_ sender: Any) {
        didTapSeeWho?()
    }
    
    @IBAction func addToLibraryButtonTaped(_ sender: Any) {
        didTapAdd?()
    }
    
    @IBAction func addToSearchButtonTaped(_ sender: Any) {
        didTapAddToSearch?()
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
