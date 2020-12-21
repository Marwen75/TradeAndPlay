//
//  AddGameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 09/12/2020.
//

import UIKit

class AddGameTableViewCell: UITableViewCell {

    @IBOutlet weak var seeWhoButton: UIButton!
    @IBOutlet weak var addToLibraryButton: UIButton!
    @IBOutlet weak var addToSearchListButton: UIButton!
    
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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
