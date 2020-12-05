//
//  IgdbService.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import Foundation
import IGDB_SWIFT_API

class IgdbService {
    
    var client: ClientProtocol
    
    init(client: ClientProtocol) {
        self.client = client
    }
    
    func getGames(withName name: String, completionHandler: @escaping (Result<Proto_GameResult, RequestException>) -> Void) {
        client.request(withName: name, endpoint: Endpoint.GAMES.rawValue, query: "fields name, summary, rating, cover, platforms, platforms.name, first_release_date, genres, genres.name, cover.image_id; search \"\(name)\"; limit 200; where version_parent = null;", dataResponse: { bytes in
            guard let games = try? Proto_GameResult(serializedData: bytes) else {return}
            completionHandler(.success(games))
        }, errorResponse: { error in
            print(error)
            completionHandler(.failure(error as! RequestException))
        })
    }
}
