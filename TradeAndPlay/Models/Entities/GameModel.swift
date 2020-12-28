//
//  GameModel.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 10/12/2020.
//

import Foundation
// Our game model object that we will use troughout our code 
struct GameModel {
    let cover: String 
    let name: String
    var platform: String
    let genres: [String]
    let firstReleaseDate: Int64
    let summary: String
    let rating: Double
    let screenshots: [String]?
    var isTraded = false
}
