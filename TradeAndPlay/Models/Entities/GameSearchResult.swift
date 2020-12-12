//
//  GameModel.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 05/12/2020.
//

import Foundation

struct Game: Decodable {
    let cover: Cover?
    let first_release_date: Int64?
    let genres: [Genre]?
    let name: String
    let platforms: [Platform]?
    let rating: Double?
    let screenshots: [Screenshot]?
    let summary: String?
}

struct Genre: Decodable {
    let name: String
}

struct Platform: Decodable {
    let name: String
}

struct Cover: Decodable {
    let image_id: String
}

struct Screenshot: Decodable {
    let image_id: String
}
