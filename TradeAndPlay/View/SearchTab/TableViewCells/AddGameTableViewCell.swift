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
    
}
