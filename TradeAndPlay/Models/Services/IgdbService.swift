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
    
    func post(withName name: String, completionHandler: @escaping (Result<[Game], ApiError>) -> Void) {
        guard let url = createRequest(name: name) else {return}
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    completionHandler(.failure(.badRequest))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseJSON = try decoder.decode([Game].self, from: data)
                    let games = responseJSON
                    completionHandler(.success(games))
                } catch let err {
                    print(err)
                    completionHandler(.failure(.noData))
                }
            }
        }
        task.resume()
    }
    
    private func createRequest(name: String) -> URLRequest? {
        let url = URL(string: ApiKey.baseUrl)
        var request = URLRequest(url: url!)
        request.httpBody = "fields name, summary, first_release_date, rating, cover, cover.url, platforms, platforms.name, genres, genres.name, cover.image_id, screenshots, screenshots.url, screenshots.image_id; search \"\(name)\"; limit 200; where version_parent = null;".data(using: .utf8, allowLossyConversion: false)
        request.httpMethod = "POST"
        request.setValue(ApiKey.id, forHTTPHeaderField: "Client-ID")
        request.setValue(ApiKey.auth, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}


