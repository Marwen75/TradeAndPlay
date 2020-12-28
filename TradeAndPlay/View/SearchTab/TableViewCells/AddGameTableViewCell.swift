//
//  AddGameTableViewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 09/12/2020.
//

import UIKit

class AddGameTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var seeWhoButton: UIButton!
    @IBOutlet weak var addToLibraryButton: UIButton!
    @IBOutlet weak var addToSearchListButton: UIButton!
    
    // MARK: - Properties
    var didTapSeeWho: (() -> Void)?
    var didTapAdd: (() -> Void)?
    var didTapAddToSearch: (() -> Void)?
    
    // MARK: - Actions
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
