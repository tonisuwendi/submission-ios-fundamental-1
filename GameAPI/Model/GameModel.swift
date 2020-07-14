//
//  GameModel.swift
//  GameAPI
//
//  Created by mac on 07/07/20.
//  Copyright © 2020 Tonsu Group. All rights reserved.
//

import UIKit

struct Games: Decodable {
    let count: Int
    let games: [Game]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case games = "results"
    }
}

struct Game: Decodable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let rating: Double
    let ratingTop: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
    }
}

struct DetailGame: Decodable {
    let description: String
    let ratingsCount: Int
    let developers: [Developer]
    let website: String
    
    private enum CodingKeys: String, CodingKey {
        case description = "description_raw"
        case ratingsCount = "ratings_count"
        case developers
        case website
    }
}

struct Developer: Decodable {
    let name: String
}
