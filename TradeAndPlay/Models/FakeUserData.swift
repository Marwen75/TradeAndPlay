//
//  FakeUserData.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 20/12/2020.
//

import Foundation

struct FakeUser {
    let nickName: String
    let city: String
    let ownedGames: [FakeOwnedGame]
    let searchedGames: [FakeSearchedGame]
}

struct FakeOwnedGame {
    let name: String
    let cover: String
    let platform: String
}

struct FakeSearchedGame {
    let name: String
    let cover: String
    let platform: String
}

struct FakeMessage {
    let content: String
    let date: Date
    let isSending: Bool
}
