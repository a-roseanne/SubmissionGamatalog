//
//  DetailGameInteractor.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import Foundation
import Combine

protocol DetailUseCase {
    func getGame() -> GameModel
    func getGameDetail(gameId: Int, completion: @escaping (Result<String, URLError>) -> Void)
    func getGameScreenshot(gameId: Int, completion: @escaping (Result<[GameScreenshotModel], URLError>) -> Void)
    func addGameToFavorite() -> AnyPublisher<Bool, Error>
    func removeGameFromFavorite() -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {
    
    private let repository: GameRepositoryProtocol
    private let game: GameModel
    
    required init(
        repository: GameRepositoryProtocol,
        game: GameModel
    ) {
        self.repository = repository
        self.game = game
    }
    
    func getGame() -> GameModel {
        return game
    }
    
    func getGameDetail(gameId: Int, completion: @escaping (Result<String, URLError>) -> Void) {
        repository.getGameDetail(gameId: gameId) { result in
            completion(result)
        }
    }
    
    func getGameScreenshot(gameId: Int, completion: @escaping (Result<[GameScreenshotModel], URLError>) -> Void) {
        repository.getGameScreenshot(gameId: gameId) { result in
            completion(result)
        }
    }
    
    func addGameToFavorite() -> AnyPublisher<Bool, Error> {
        return repository.addGameToFavorite(from: game)
    }
    
    func removeGameFromFavorite() -> AnyPublisher<Bool, Error> {
        return repository.removeGameFromFavorite(from: game)
    }
}
