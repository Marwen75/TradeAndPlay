//
//  Extension+UITableviewCell.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 11/12/2020.
//

import Foundation
import UIKit

// an extension to calculate the release date of a game using the unix timestamp provided by the API 
extension UITableViewCell {
    func configureDate(model: GameModel) -> String {
        let timeStamp = model.firstReleaseDate
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
