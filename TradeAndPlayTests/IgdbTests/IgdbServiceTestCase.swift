//
//  IgdbServiceTestCase.swift
//  TradeAndPlayTests
//
//  Created by Marwen Haouacine on 26/12/2020.
//

import XCTest
@testable import TradeAndPlay

class IgdbServiceTestCase: XCTestCase {
    
    var expectation: XCTestExpectation!
    var apiError: ApiError!
    
    override func setUp() {
        super.setUp()
        expectation = XCTestExpectation(description: "Wait for queue change.")
    }
    
    override func tearDown() {
        super.tearDown()
        expectation = nil
    }
    
    // MARK: - TESTS FAKE DATA
    
    // Testing the IGDB service if there's an error
    func testIgdbPostShouldPostFailedCallbackIfError() {
        
        let igdbService = IgdbService(session: URLSessionFake(data: nil, response: nil, error: apiError))
        
        igdbService.post(withName: "Medievil", platform: "PlayStation", completionHandler: { result in
            guard case .failure(let error) = result else {
                XCTFail("Should Fail")
                return
            }
            XCTAssertNotNil(error)
            XCTAssertTrue(error.errorDescription == "Oups !")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the IGDBservice  if there's no data
    func testIgdbPostShouldPostFailedCallbackIfNoData() {
        
        let igdbService = IgdbService(session: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: apiError))
        
        igdbService.post(withName: "Medievil", platform: "PlayStation", completionHandler: { result in
            guard case .failure(let error) = result else {
                XCTFail("Should Fail")
                return
            }
            XCTAssertNotNil(error)
            XCTAssertTrue(error == .badRequest)
            XCTAssertTrue(error.failureReason == "Network resquest has failed")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    // Testing the IGDB service if there's an incorrect response
    func testIgdbPostShouldPostFailedCallbackIfIncorrectResponse() {
        
        let igdbService = IgdbService(session: URLSessionFake(data: FakeResponseData.igdbCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        igdbService.post(withName: "Medievil", platform: "PlayStation", completionHandler: { result in
            guard case .failure(let error) = result else {
                XCTFail("Should Fail")
                return
            }
            XCTAssertNotNil(error)
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    // Testing the IGDB service if there's incorrect data
    func testIgdbPostShouldPostFailedCallbackIfIncorrectData() {
        
        let igdbService = IgdbService(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        igdbService.post(withName: "Medievil", platform: "PlayStation", completionHandler: { result in
            guard case .failure(let error) = result else {
                XCTFail("Should Fail")
                return
            }
            XCTAssertTrue(error == .noData)
            XCTAssertTrue(error.failureReason == "These data can't be retrieved at the moment.")
            XCTAssertNotNil(error)
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the IGDB service if everything went fine
    func testIgdbPostShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        let igdbService = IgdbService(session: URLSessionFake(data: FakeResponseData.igdbCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        igdbService.post(withName: "Medievil", platform: "PlayStation", completionHandler: { result in
            guard case .success(let result) = result else {
                XCTFail("Should pass")
                return
            }
            XCTAssertNotNil(result)
            XCTAssertTrue(result.first?.name == "MediEvil 2")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - TESTS REAL DATA
    
    // Testing the IGDB service if everything went fine
    
    func testIgdbPostShouldPostSuccessCallbackWithRealSession() {
        
        let igdbService = IgdbService(session: URLSession(configuration: .default))
        
        igdbService.post(withName: "Medievil", platform: "PlayStation", completionHandler: { result in
            guard case .success(let result) = result else {
                XCTFail("Should pass")
                return
            }
            XCTAssertNotNil(result)
            XCTAssertTrue(result.first?.name == "MediEvil 2")
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10)
    }
}
