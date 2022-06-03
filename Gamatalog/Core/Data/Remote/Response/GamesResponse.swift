//
//  GamesResponse.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import Foundation

struct GamesResponse: Decodable {
    var results: [GameResponse]
}

struct GameResponse: Decodable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating
    }
}

struct GameDetailResponse: Decodable {
    let id: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case description = "description_raw"
    }
}

struct GameScreenshots: Codable {
    let results: [GameImg]
}

struct GameImg: Codable, Identifiable {
    var id: Int
    var image: String
    enum CodingKeys: String, CodingKey {
        case id, image
    }
}
