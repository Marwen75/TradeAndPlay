//
//  IgdbService.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 01/12/2020.
//

import Foundation

class IgdbService {
    
    var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
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
    
    private func createGameModels(response: [Game]) -> [GameModel] {
        var gameModels: [GameModel] = []
        response.forEach { game in
            gameModels.append(GameModel(cover: game.cover?.image_id ?? "",
                                        name: game.name, platform: "",
                                        genres: sortGameData(i: 1, game: game),
                                        firstReleaseDate: game.first_release_date ?? 0,
                                        summary: game.summary ?? "N/A",
                                        rating: game.rating ?? 0,
                                        screenshots: sortGameData(i: 0, game: game))) }
        return gameModels
    }
    
    private func sortGameData(i: Int, game: Game) -> [String] {
        var dataArray: [String] = []
        if i == 0 {
            game.screenshots?.forEach {dataArray.append($0.image_id)}
            return dataArray
        } else {
            game.genres?.forEach {dataArray.append($0.name)}
            return dataArray
        }
    }
}


