//
//  GameModel.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 05/12/2020.
//

import Foundation

struct GameSearchResult: Decodable {
    let games: [Game]
}

struct Game: Decodable {
    let id: Int
    let cover: Cover
    let first_release_date: Int64
    let genres: [Genre]
    let name: String
    let platforms: [Platform]
    let rating: Double
    let screenshots: [Screenshot]
    let summary: String
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct Platform: Decodable {
    let id: Int
    let name: String
}

struct Cover: Decodable {
    let id: Int
    let image_id: String
    let url: String
}

struct Screenshot: Decodable {
    let id: Int
    let image_id: String
    let url: String
}
