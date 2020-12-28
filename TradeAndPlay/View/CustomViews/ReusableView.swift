//
//  ReusableView.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 11/12/2020.
//

import Foundation
import UIKit

// A protocol that will help us to register and dequeue in an easier way using a default reuse identifier
protocol ReusableView {
    
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UICollectionViewCell: ReusableView {}
