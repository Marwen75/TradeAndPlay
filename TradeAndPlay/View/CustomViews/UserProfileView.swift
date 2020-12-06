//
//  UserProfileView.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 06/12/2020.
//

import UIKit

class UserProfileView: NibView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var gameToTradeCollectionView: UICollectionView!
    
    @IBOutlet weak var searchedGamesCollectionView: UICollectionView!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
}
