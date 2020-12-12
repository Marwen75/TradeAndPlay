//
//  DataStorageError.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 10/12/2020.
//

import Foundation

enum DataStorageError: Error {
    
    case noPlayerFound
    case noGameInLibrary
    case noGameFound
    case noInternet

    var errorDescription: String {
       return "Oups !"
    }
    var failureReason: String {
        switch self {
        case .noPlayerFound:
            return "No trader with this name found."
        case .noGameInLibrary:
            return "You don't have any games in your library yet"
        case .noGameFound:
            return "No game with this name to trade actually, add it to you search list"
        case .noInternet:
            return "Service unavailable. You don't seem to have an internet connexion."
        }
    }
}
