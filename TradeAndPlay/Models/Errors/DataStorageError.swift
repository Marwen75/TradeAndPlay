//
//  DataStorageError.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 10/12/2020.
//

import Foundation

enum DataStorageError: Error {
    
    case noPlayerFound
    case noPlayerWithGameFound
    case noGameInLibrary
    case noGameFound
    case alreadyInSearchList

    var errorDescription: String {
       return "Oups !"
    }
    var failureReason: String {
        switch self {
        case .noPlayerFound:
            return "No user with this name found."
        case .noPlayerWithGameFound:
            return "No user has this game to trade, add the game to your search list"
        case .noGameInLibrary:
            return "You don't have any games in your library yet"
        case .noGameFound:
            return "No game with this name to trade actually, add it to you search list"
        case .alreadyInSearchList:
            return "This game is already in your search list !"
        }
    }
}
