//
//  FakeResponseData.swift
//  TradeAndPlayTests
//
//  Created by Marwen Haouacine on 26/12/2020.
//

import Foundation

// Our fake response data to mock an Api call
class FakeResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.hackingwithswift.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.hackingwithswift.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    static var igdbCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "IGDB", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static let incorrectData = "fsdfqefsf".data(using: .utf8)
}
