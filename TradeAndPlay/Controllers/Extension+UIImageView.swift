//
//  Extension+UIImageView.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 02/12/2020.
//

import Foundation
import UIKit

// An extension for UIImageView so we can load the image from the url given by th API
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
