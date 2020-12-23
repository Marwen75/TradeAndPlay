//
//  FakeUserData.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 20/12/2020.
//

import Foundation

/*Optional("co1wyy")
Optional("The Witcher 3: Wild Hunt")
Optional("PlayStation 4")
Optional("co1tmu")
Optional("God of War")
Optional("PlayStation 4")
Optional("co2gu4")
Optional("Hagane: The Final Conflict")
Optional("Super Nintendo Entertainment System (SNES)")
Optional("co23jy")
Optional("Super Mario World")
Optional("Super Nintendo Entertainment System (SNES)")
Optional("co25w2")
Optional("Demon\'s Crest")
Optional("Super Nintendo Entertainment System (SNES)")
Optional("co2a23")
Optional("Sekiro: Shadows Die Twice")
Optional("PlayStation 4")
Optional("co1yad")
Optional("Shenmue")
Optional("Dreamcast")
*/


struct FakeUserData {
    
    static let fakeUsers = [FakeUser(nickName: "Igo",
                                     city: "Boulogne",
                                     rating: 100,
                                     ownedGamesList: [FakeOwnedGame(name: "The Witcher 3: Wild Hunt",
                                                                    cover: "co1wyy",
                                                                    platform: "PlayStation 4")],
                                     searchGamesList: [FakeSearchedGame(name: "God of War",
                                                                        cover: "co1tmu",
                                                                        platform: "PlayStation 4")],
                                     messages: [FakeMessage(content: "Hello !",
                                                            sender: "Igo",
                                                            date: Date())]),
                            FakeUser(nickName: "Franzy",
                                     city: "Boulogne",
                                     rating: 100,
                                     ownedGamesList: [FakeOwnedGame(name: "God of War",
                                                                    cover: "co1tmu",
                                                                    platform: "PlayStation 4")],
                                     searchGamesList: [FakeSearchedGame(name: "",
                                                                        cover: "",
                                                                        platform: "")],
                                     messages: [FakeMessage(content: "Yooooo",
                                                            sender: "Franzy",
                                                            date: Date())]),
                            FakeUser(nickName: "Elea",
                                     city: "Boulogne",
                                     rating: 100,
                                     ownedGamesList: [FakeOwnedGame(name: "Sekiro: Shadows Die Twice",
                                                                    cover: "co2a23",
                                                                    platform: "PlayStation 4")],
                                     searchGamesList: [FakeSearchedGame(name: "",
                                                                        cover: "",
                                                                        platform: "")],
                                     messages: [FakeMessage(content: "Aloha",
                                                            sender: "Elea",
                                                            date: Date())]),
                            FakeUser(nickName: "Flop",
                                     city: "Boulogne",
                                     rating: 100,
                                     ownedGamesList: [FakeOwnedGame(name: "Shenmue",
                                                                    cover: "co1yad",
                                                                    platform: "Dreamcast")],
                                     searchGamesList: [FakeSearchedGame(name: "",
                                                                        cover: "",
                                                                        platform: "")],
                                     messages: [FakeMessage(content: "You here?",
                                                            sender: "Flop",
                                                            date: Date())]),
    ]
}

struct FakeUser {
    let nickName: String
    let city: String
    let rating: Int
    let ownedGamesList: [FakeOwnedGame]
    let searchGamesList: [FakeSearchedGame]
    let messages: [FakeMessage]
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
    let sender: String
    let date: Date
}
