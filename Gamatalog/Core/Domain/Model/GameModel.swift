//
//  GameModel.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

struct GameModel: Equatable, Identifiable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    var favorite: Bool = false
}

struct GameDetailModel: Equatable, Identifiable {
    let id: Int
    let description: String
}

struct GameScreenshotModel: Equatable, Identifiable {
    let id: Int
    let imgUrl: String
}
