//
//  MessageStorageTestCase.swift
//  TradeAndPlayTests
//
//  Created by Marwen Haouacine on 26/12/2020.
//

import XCTest
@testable import TradeAndPlay
import CoreData

class MessageStorageTestCase: XCTestCase {
    
    // MARK: - Properties
    var coreDataStack: CoreDataStack!
    var messageStorage: MessageStorage!
    var fakeUser: FakeUser!
    var expectation: XCTestExpectation!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        messageStorage = MessageStorage(coreDataStack: coreDataStack)
        fakeUser = FakeUser(nickName: "lolo", city: "Paris", rating: 100, ownedGamesList: [FakeOwnedGame(name: "", cover: "", platform: "")], messages: [FakeMessage(content: "Hello", sender: "lolo", date: Date.init())])
        expectation = XCTestExpectation(description: "Wait for queue change.")
    }
    
    override func tearDown() {
        super.tearDown()
        messageStorage = nil
        coreDataStack = nil
        expectation = nil
    }
    
    // MARK: - Tests
    func testIfANewFakeDiscussionWithUserIsCreatedThenItShouldAppearInCoreData() {
        messageStorage.addFakeDiscussion(fakeUser: fakeUser)
        messageStorage.fetchDiscussions(completionHandler: {result in
            guard case .success(let result) = result else {
                XCTFail("Must pass")
                return
            }
            XCTAssertNotNil(result.last?.messages)
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfANewDiscussionWithUserIsCreatedThenItShouldAppearInCoreData() {
        messageStorage.addNewDiscussion(recipient: fakeUser, completionHandler: { discussion in
            print(discussion)
        })
        messageStorage.fetchDiscussions(completionHandler: {result in
            guard case .success(let result) = result else {
                XCTFail("Must pass")
                return
            }
            XCTAssertNotNil(result.last?.recipient == self.fakeUser.nickName)
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfThereIsADiscussionThenItShouldAppearWhenFetched() {
        messageStorage.addFakeDiscussion(fakeUser: fakeUser)
        messageStorage.fetchDiscussionByUser(named: fakeUser.nickName, completionHandler: { result in
            guard case .success(let result) = result else {
                XCTFail("must find a discussion")
                return
            }
            XCTAssertTrue(result.recipient == "lolo")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfThereIsADiscussionThenTheMessagesInsideItCanBeFetched() {
        messageStorage.addFakeDiscussion(fakeUser: fakeUser)
        messageStorage.fetchMessagesFromDiscussion(recipient: fakeUser.nickName, completionHandler: { result in
            guard case .success(let result) = result else {
                XCTFail("should be a message existing")
                return
            }
            XCTAssertTrue(result.last?.content == "Hello")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfThereIsNoDiscussionThenCallbackShouldFail() {
        messageStorage.addFakeDiscussion(fakeUser: fakeUser)
        messageStorage.deleteFakeDiscussions()
        messageStorage.fetchDiscussions(completionHandler: { result in
            guard case .failure(let error) = result else {
                XCTFail("Should fail without discussion")
                return
            }
            XCTAssertTrue(error.failureReason == "You don't have any messages yet")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfThereIsNoDiscussionWithANamedUserThenCallbackShouldFail() {
        messageStorage.addFakeDiscussion(fakeUser: fakeUser)
        messageStorage.deleteFakeDiscussions()
        messageStorage.fetchDiscussionByUser(named: fakeUser.nickName, completionHandler: { result in
            guard case .failure(let error) = result else {
                XCTFail("Should fail without discussion")
                return
            }
            XCTAssertTrue(error.failureReason == "You don't have any messages yet")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfThereIsNoDiscussionThenThereIsNoMessagesAttachedToItAndCallbackShouldFail() {
        messageStorage.addFakeDiscussion(fakeUser: fakeUser)
        messageStorage.deleteFakeDiscussions()
        messageStorage.fetchMessagesFromDiscussion(recipient: fakeUser.nickName, completionHandler: { result in
            guard case .failure(let error) = result else {
                XCTFail("Should fail without discussion")
                return
            }
            XCTAssertTrue(error.failureReason == "You don't have any messages yet")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testIfANewMessageIsAddedThenItShouldAppearInCoreDate() {
        let discussion = Discussion(context: coreDataStack.viewContext)
        messageStorage.addMessageToDiscussion(discussion: discussion, content: "Yo", completionHandler: {
        })
        XCTAssertTrue(discussion.messages?.count == 1)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 0.5)
    }

}
