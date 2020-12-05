//
//  ApiError.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import Foundation


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
            return "Ces données ne peuvent pas être fournies pour le moment."
        case .badRequest:
            return "La requète réseau a échouée"
        case .noInternet:
            return "Le service est indisponible! Vous ne semblez pas connecté à internet"
        }
    }
}
