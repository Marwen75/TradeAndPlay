//
//  FakeUserData.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 20/12/2020.
//

import Foundation

// This object will mock users of the app and their data to show a demo of tha app features
struct FakeUserData {
    
    static let fakeUsers = [FakeUser(nickName: "Igo",
                                     city: "Boulogne",
                                     ownedGamesList: [FakeOwnedGame(name: "The Witcher 3: Wild Hunt",
                                                                    cover: "co1wyy",
                                                                    platform: "PlayStation 4")],
                                     messages: [FakeMessage(content: "Hello !",
                                                            sender: "Igo",
                                                            date: Date.init(timeIntervalSinceReferenceDate: 630000000))]),
                            FakeUser(nickName: "Franzy",
                                     city: "Boulogne",
                                     ownedGamesList: [FakeOwnedGame(name: "God of War",
                                                                    cover: "co1tmu",
                                                                    platform: "PlayStation 4")],
                                     messages: [FakeMessage(content: "Yooooo",
                                                            sender: "Franzy",
                                                            date: Date.init(timeIntervalSinceReferenceDate: 629000000))]),
                            FakeUser(nickName: "Elea",
                                     city: "Boulogne",
                                     ownedGamesList: [FakeOwnedGame(name: "Sekiro: Shadows Die Twice",
                                                                    cover: "co2a23",
                                                                    platform: "PlayStation 4")],
                                     messages: [FakeMessage(content: "Aloha",
                                                            sender: "Elea",
                                                            date: Date.init(timeIntervalSinceReferenceDate: 628000000))]),
                            FakeUser(nickName: "Flop",
                                     city: "Boulogne",
                                     ownedGamesList: [FakeOwnedGame(name: "Shenmue",
                                                                    cover: "co1yad",
                                                                    platform: "Dreamcast")],
                                     messages: [FakeMessage(content: "You here?",
                                                            sender: "Flop",
                                                            date: Date())]),
                            FakeUser(nickName: "Zari",
                                     city: "Arcueil",
                                     ownedGamesList: [FakeOwnedGame(name: "MediEvil 2",
                                                                    cover: "co1tji",
                                                                    platform: "PlayStation")],
                                     messages: [FakeMessage(content: "",
                                                            sender: "",
                                                            date: Date())])
    ]
}

struct FakeUser {
    let nickName: String
    let city: String
    let ownedGamesList: [FakeOwnedGame]
    let messages: [FakeMessage]
}

struct FakeOwnedGame {
    let name: String
    let cover: String
    let platform: String
}

struct FakeMessage {
    let content: String
    let sender: String
    let date: Date
}
