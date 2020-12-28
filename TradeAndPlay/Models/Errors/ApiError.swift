//
//  ApiError.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import Foundation

// An enum for the errors that can occur during our API calls
enum ApiError: Error {
    
    case noData
    case badRequest
    case noInternet

    var errorDescription: String {
       return "Oups !"
    }
    var failureReason: String {
        switch self {
        case .noData:
            return "These data can't be retrieved at the moment."
        case .badRequest:
            return "Network resquest has failed"
        case .noInternet:
            return "Service unavailable. You don't seem to have an internet connexion."
        }
    }
}
