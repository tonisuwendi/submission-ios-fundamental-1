//
//  GameViewModel.swift
//  GameAPI
//
//  Created by mac on 07/07/20.
//  Copyright © 2020 Tonsu Group. All rights reserved.
//

import Foundation

class GameViewModel {
    
    private var apiService = APIService()
    private var getGamesku = [Game]()
    private var detailGame: [DetailGame] = []
    
    func fetchGameData(completion: @escaping () -> ()) {
        
        apiService.getGames { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.getGamesku = listOf.games
                completion()
            case .failure(let error):
                print("error prosesing json data: \(error)")
            }
            
        }
        
    }
    
    func seacrhGame(search: String, completion: @escaping () -> ()) {
        
        apiService.searchGame(search: search) { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.getGamesku = listOf.games
                completion()
            case .failure(let error):
                print("error prosesing json data: \(error)")
            }
        }
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if getGamesku.count != 0 {
            return 20
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Game {
        if getGamesku.count != 0 {
            return getGamesku[indexPath.row]
        }
        return nil!
    }
    
}
