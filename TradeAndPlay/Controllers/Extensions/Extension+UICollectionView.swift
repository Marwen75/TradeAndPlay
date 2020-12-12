//
//  Extension+UICollectionView.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 11/12/2020.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Problem for dequeuing")
        }
        return cell
    }
    
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className = cellType.reuseIdentifier
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }

     func register<T: UICollectionViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
}
