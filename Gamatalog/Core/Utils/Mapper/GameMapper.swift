//
//  GameMapper.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import Foundation

final class GameMapper {
    static func mapGameResponsesToEntities(
        input gameResponses: [GameResponse]
    ) -> [GameEntity] {
        return gameResponses.map { result in
            let newGame = GameEntity()
            newGame.id = result.id
            newGame.name = result.name
            newGame.released = result.released ?? "No Released Date"
            newGame.backgroundImage = result.backgroundImage ?? ""
            newGame.rating = result.rating ?? 0.0
            return newGame
        }
    }
    static func mapGameListResponsesToDomains(
        input gameResponses: [GameResponse]
    ) -> [GameModel] {
        return gameResponses.map { result in
            return GameModel(
                id: result.id,
                name: result.name,
                released: result.released ?? "No Released Date",
                backgroundImage: result.backgroundImage ?? "",
                rating: result.rating ?? 0.0
            )
        }
    }
    
    static func mapGameEntitiesToDomains(
        input gameEntities: [GameEntity]
    ) -> [GameModel] {
        return gameEntities.map { result in
            return GameModel(
                id: result.id,
                name: result.name,
                released: result.released ?? "No Released Date",
                backgroundImage: result.backgroundImage ?? "",
                rating: result.rating,
                favorite: result.favorite
            )
        }
    }
    
    static func mapGameScreenshotResponsesToDomains(
        input gameImages: [GameImg]
    ) -> [GameScreenshotModel] {
        return gameImages.map { result in
            return GameScreenshotModel(
                id: result.id,
                imgUrl: result.image)
        }
    }
    
    static func mapGameDomainToEntity(
        input game: GameModel
    ) -> GameEntity {
        let newGame = GameEntity()
        newGame.id = game.id
        newGame.name = game.name
        newGame.released = game.released 
        newGame.backgroundImage = game.backgroundImage 
        newGame.rating = game.rating 
        return newGame
    }
}
