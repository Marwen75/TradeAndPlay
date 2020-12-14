//
//  GameModel.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 10/12/2020.
//

import Foundation

struct GameModel {
    let cover: String 
    let name: String
    let platforms: [String]?
    let genres: [String]
    let firstReleaseDate: Int64
    let summary: String
    let rating: Double
    let screenshots: [String]?
    var isTraded = false
}

