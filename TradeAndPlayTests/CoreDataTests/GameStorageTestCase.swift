//
//  CoreDataStorageTestCase.swift
//  TradeAndPlayTests
//
//  Created by Marwen Haouacine on 26/12/2020.
//

import XCTest
@testable import TradeAndPlay
import CoreData

class GameStorageTestCase: XCTestCase {
    
    // MARK: - Properties
    var coreDataStack: CoreDataStack!
    var gameStorage: GameStorage!
    var gameModel: GameModel!
    var fakeUser: FakeUser!
    var expectation: XCTestExpectation!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        gameStorage = GameStorage(coreDataStack: coreDataStack)
        gameModel = GameModel(cover: "co1tjk",
                              name: "MediEvil", platform: "PlayStation",
                              genres: ["Platform", "Puzzle", "Hack and slash/Beat \'em up", "Adventure"],
                              firstReleaseDate: 907200000, summary: "Summary", rating: 80.8553305473621,
                              screenshots: ["yyvzhgyt4ycz5cuatidm", "prgkaeeug1puvn501szs",
                                            "nb2gwjgvtrsvuysa9h5x", "cwotp16jsnfttmyip1op",
                                            "tmak1bz9kvng33n67cbl"])
        fakeUser = FakeUser(nickName: "lolo", city: "Paris", rating: 100,
                            ownedGamesList: [FakeOwnedGame(name: "",
                                                           cover: "",
                                                           platform: "")],
                            messages: [FakeMessage(content: "",
                                                   sender: "lolo",
                                                   date: Date.init())])
        expectation = XCTestExpectation(description: "Wait for queue change.")
    }
    
    override func tearDown() {
        super.tearDown()
        gameStorage = nil
        coreDataStack = nil
        gameModel = nil
        expectation = nil
    }
    
    // MARK: - Tests
    func testIfAGameIsAddedToOwnedListThenTheGameShouldAppearInCoreData() {
        gameStorage.addToOwnedList(game: gameModel, platform: gameModel.platform, completionHandler: { result in
            guard case .success(_) = result else {
                XCTFail("Test must succeed.")
                return
            }
        })
        gameStorage.fetchOwnedGames(completionHandler: { result in
            guard case .success(let ownedGames) = result else {
                XCTFail("Must Succeed")
                return
            }
            XCTAssertNotNil(ownedGames)
            XCTAssertTrue(ownedGames.last?.name == "MediEvil")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfAGameIsAddedToSearchListThenTheGameShouldAppearInCoreData() {
        gameStorage.addToSearchList(game: gameModel, platform: gameModel.platform, completionHandler: { result in
            guard case .success(_) = result else {
                XCTFail("Test must succeed.")
                return
            }
        })
        gameStorage.fetchSearchedGames(completionHandler: { result in
            guard case .success(let searchedGames) = result else {
                XCTFail("Must Succeed")
                return
            }
            XCTAssertNotNil(searchedGames)
            XCTAssertTrue(searchedGames.last?.name == "MediEvil")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfAGameIsAddedToOwnedListAndDeletedThenTheGameShouldNotAppearInCoreData() {
        gameStorage.addToOwnedList(game: gameModel, platform: gameModel.platform, completionHandler: { result in
            guard case .success(_) = result else {
                XCTFail("Test must succeed.")
                return
            }
        })
        gameStorage.deleteFromOwnedList(gameNamed: gameModel.name, completionHandler: {})
        gameStorage.fetchOwnedGames(completionHandler: { result in
            guard case .success(let ownedGames) = result else {
                XCTFail("Must Succeed")
                return
            }
            XCTAssertTrue(ownedGames.count == 0)
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfAGameIsAddedToSearchListAndDeletedThenTheGameShouldNotAppearInCoreData() {
        gameStorage.addToSearchList(game: gameModel, platform: gameModel.platform, completionHandler: { result in
            guard case .success(_) = result else {
                XCTFail("Test must succeed.")
                return
            }
        })
        gameStorage.deleteFromSearchList(gameNamed: gameModel.name, completionHandler: {})
        gameStorage.fetchSearchedGames(completionHandler: { result in
            guard case .success(let searchedGames) = result else {
                XCTFail("Must Succeed")
                return
            }
            XCTAssertTrue(searchedGames.count == 0)
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfAGameIsAddedToOwnedGameListItShouldNotBeAddedTwice() {
        gameStorage.addToOwnedList(game: gameModel, platform: gameModel.platform, completionHandler: { result in
            guard case .success(_) = result else {
                XCTFail("Test must succeed.")
                return
            }
        })
        gameStorage.addToOwnedList(game: gameModel, platform: gameModel.platform, completionHandler: { result in
            guard case .failure(let error) = result else {
                XCTFail("Test must Fail.")
                return
            }
            XCTAssertTrue(error.errorDescription == "Oups !")
            XCTAssertTrue(error.failureReason == "This game is already in you Owned list !")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfAGameIsAddedToSearchListItShouldNotBeAddedTwice() {
        gameStorage.addToSearchList(game: gameModel, platform: gameModel.platform, completionHandler: { result in
            guard case .success(_) = result else {
                XCTFail("Test must succeed.")
                return
            }
        })
        gameStorage.addToSearchList(game: gameModel, platform: gameModel.platform, completionHandler: { result in
            guard case .failure(let error) = result else {
                XCTFail("Test must Fail.")
                return
            }
            print(error)
            XCTAssertTrue(error.failureReason == "This game is already in your search list !")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfAGameIsTradedThenItShouldAppearInCoreDate() {
        let game = OwnedGame(context: coreDataStack.viewContext)
        game.name = "Yup"
        gameStorage.addTrade(game: game, recipient: fakeUser)
        gameStorage.fetchCurrentTrades(completionHandler: { result in
            guard case .success(let result) = result else {
                XCTFail("must pass")
                return
            }
            XCTAssertTrue(result.last?.isTraded == true)
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfATradeIsOverAndDeletedThenItShouldNotAppearInCoreDate() {
        let game = OwnedGame(context: coreDataStack.viewContext)
        game.name = "Yup"
        gameStorage.addTrade(game: game, recipient: fakeUser)
        gameStorage.deleteTrade(game: game)
        gameStorage.fetchCurrentTrades(completionHandler: { result in
            guard case .success(let result) = result else {
                XCTFail("must fail")
                return
            }
            XCTAssertTrue(result.count == 0)
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
}
