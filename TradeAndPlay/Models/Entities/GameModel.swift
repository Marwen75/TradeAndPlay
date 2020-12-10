//
//  GameModel.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 10/12/2020.
//

import Foundation

struct GameModel {
    let id: Int
    let cover: CoverModel?
    let name: String
    let platforms: [PlatformModel]?
    let isOwned: Bool = false
    let isSearched: Bool = false
    let isTraded: Bool = false
}

struct PlatformModel {
    let id: Int
    let name: String
}

struct CoverModel {
    let id: Int
    let image_id: String
    let url: String
}
