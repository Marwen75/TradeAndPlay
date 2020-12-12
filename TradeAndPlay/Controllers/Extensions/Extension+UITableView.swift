//
//  UITableView.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 11/12/2020.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Problem for dequeuing")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.reuseIdentifier
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }

     func register<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
}
