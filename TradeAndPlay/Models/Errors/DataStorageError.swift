//
//  DataStorageError.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 10/12/2020.
//

import Foundation

enum DataStorageError: Error {
    
    case noPlayerFound
    case noGameFound
    case noInternet

    var errorDescription: String {
       return "Oups !"
    }
    var failureReason: String {
        switch self {
        case .noPlayerFound:
            return "No trader with this name found."
        case .noGameFound:
            return "No game with this name to trade actually"
        case .noInternet:
            return "Service unavailable. You don't seem to have an internet connexion."
        }
    }
}
