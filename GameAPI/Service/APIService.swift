//
//  Service.swift
//  GameAPI
//
//  Created by mac on 07/07/20.
//  Copyright © 2020 Tonsu Group. All rights reserved.
//

import UIKit

class APIService {
    
    private var dataTask: URLSessionTask?
    
    func getGames(completion: @escaping (Result<Games, Error>) -> Void) {
        let getUrl = "https://api.rawg.io/api/games"
        
        guard let url = URL(string: getUrl) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("Datatask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty response")
                return
            }
            print("response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Games.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func searchGame(search: String, completion: @escaping (Result<Games, Error>) -> Void) {
        
        let search = search
        
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        
        components.queryItems = [
            URLQueryItem(name: "search", value: search)
        ]
        
        let request = URLRequest(url: components.url!)
        
        dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("Datatask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty response")
                return
            }
            print("response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Games.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func detailGame(id: Int, completion: @escaping (DetailGame) -> Void) {
        
        let idGame = id
        
        let getUrl = "https://api.rawg.io/api/games/\(idGame)"
        
        guard let url = URL(string: getUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let games = try! JSONDecoder().decode(DetailGame.self, from: data!)
            
            DispatchQueue.main.async {
                completion(games)
            }
        }.resume()
    }
    
}
