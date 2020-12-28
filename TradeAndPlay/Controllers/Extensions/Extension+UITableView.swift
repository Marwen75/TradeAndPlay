//
//  UITableView.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 11/12/2020.
//

import UIKit

// An extension using generics to give us an easier way to register an dequeue tableview cells
extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Problem for dequeuing")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.defaultReuseIdentifier
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }

     func register<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
}
