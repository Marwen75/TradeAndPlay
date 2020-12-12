//
//  ReusableView.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 11/12/2020.
//

import Foundation
import UIKit

protocol ReusableView {
    
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UICollectionViewCell: ReusableView {}
