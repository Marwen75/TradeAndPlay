//
//  IgdbWrapperClient.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 04/12/2020.
//

import Foundation
import IGDB_SWIFT_API

class IgdbWrapperClient: ClientProtocol {
    
    private let wrapper = IGDBWrapper(clientID: ApiKey.id, accessToken: ApiKey.auth)
    
    func request(withName name: String, endpoint: String, query: String, dataResponse: @escaping (Data) -> (Void), errorResponse: @escaping (Error) -> (Void)) {
        wrapper.apiProtoRequest(endpoint: .GAMES, apicalypseQuery: query, dataResponse: { bytes in
            dataResponse(bytes)
        }, errorResponse: { error in
            errorResponse(error)
        })
    }
}
