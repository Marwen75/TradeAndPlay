//
//  IgdbService.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import Foundation

// Our service that will use the IGDB api to make API calls
class IgdbService {
    
    // MARK: - Properties
    var session: URLSession
    
    // MARK: - Init
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - Methods
    func post(withName name: String, platform: String, completionHandler: @escaping (Result<[GameModel], ApiError>) -> Void) {
        guard let url = createRequest(name: name, platform: platform) else {return}
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async { [self] in
                guard let data = data, error == nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    completionHandler(.failure(.badRequest))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseJSON = try decoder.decode([Game].self, from: data)
                    let gameModels = createGameModels(response: responseJSON)
                    completionHandler(.success(gameModels))
                } catch let err {
                    print(err)
                    completionHandler(.failure(.noData))
                }
            }
        }
        task.resume()
    }
    
    private func createRequest(name: String, platform: String) -> URLRequest? {
        let url = URL(string: ApiConfig.baseUrl)
        var request = URLRequest(url: url!)
        request.httpBody = "fields name, summary, first_release_date, rating, cover, platforms, platforms.name, genres, genres.name, cover.image_id, screenshots, screenshots.image_id; search \"\(name)\"; limit 200; where version_parent = null; where platforms.name = \"\(platform)\";".data(using: .utf8, allowLossyConversion: false)
        request.httpMethod = "POST"
        request.setValue(ApiKey.id, forHTTPHeaderField: "Client-ID")
        request.setValue(ApiKey.auth, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    // A function to help us create gameModels that are easier to work with
    private func createGameModels(response: [Game]) -> [GameModel] {
        var gameModels: [GameModel] = []
        response.forEach { game in
            gameModels.append(GameModel(cover: game.cover?.image_id ?? "",
                                        name: game.name, platform: "",
                                        genres: game.genres?.compactMap {$0.name} ?? ["N/A"],
                                        firstReleaseDate: game.first_release_date ?? 0,
                                        summary: game.summary ?? "N/A",
                                        rating: game.rating ?? 0,
                                        screenshots: game.screenshots?.compactMap {$0.image_id}))}
        return gameModels
    }
}
