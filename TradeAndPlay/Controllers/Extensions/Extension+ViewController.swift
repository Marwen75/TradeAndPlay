//
//  Extension+ViewController.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import Foundation
import UIKit

// An extension that will display our alerts throughout our view controllers
extension UIViewController {
    
    func displayAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func configureDate(game: Game) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(game.first_release_date ?? 0))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        return "First released: \(strDate)"
    }
    
    func configureRatings(game: Game) -> String {
        return "Ratings: \(String(Int(round(game.rating ?? 0))))/100"
    }
}
