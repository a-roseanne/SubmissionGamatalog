//
//  GameRepository.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
    func getGameList() -> AnyPublisher<[GameModel], Error>
    func getGameDetail(gameId: Int, result: @escaping (Result<String, URLError>) -> Void)
    func getGameScreenshot(gameId: Int, result: @escaping (Result<[GameScreenshotModel], URLError>) -> Void)
    func getFavoritedGames() -> AnyPublisher<[GameModel], Error>
    func addGameToFavorite(from game: GameModel) -> AnyPublisher<Bool, Error>
    func removeGameFromFavorite(from game: GameModel) -> AnyPublisher<Bool, Error>
}

final class GameRepository: NSObject {
    typealias GameInstance = (LocaleDataSource, RemoteDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: GameInstance = { localRepository, remoteRepository in
        return GameRepository(locale: localRepository, remote: remoteRepository)
    }
}

extension GameRepository: GameRepositoryProtocol {
    
    func getGameList() -> AnyPublisher<[GameModel], Error> {
          return self.locale.getGameList()
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
              if result.isEmpty {
                return self.remote.getGameList()
                  .map { GameMapper.mapGameResponsesToEntities(input: $0) }
                  .flatMap { self.locale.addGameList(from: $0) }
                  .filter { $0 }
                  .flatMap { _ in self.locale.getGameList()
                    .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
                  }
                  .eraseToAnyPublisher()
              } else {
                return self.locale.getGameList()
                  .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
                  .eraseToAnyPublisher()
              }
            }
            .eraseToAnyPublisher()
        }

    func getGameDetail(gameId: Int, result: @escaping (Result<String, URLError>) -> Void) {
        self.remote.getGameDetail(gameId: gameId) { remoteResponses in
            switch remoteResponses {
            case .success(let gameResponses):
                result(.success(gameResponses))
            case .failure(let err):
                result(.failure(err))
            }
        }
    }
    
    func getGameScreenshot(gameId: Int, result: @escaping (Result<[GameScreenshotModel], URLError>) -> Void) {
        self.remote.getGameScreenshot(gameId: gameId) { remoteResponses in
            switch remoteResponses {
            case .success(let gameImages):
                let resultList = GameMapper.mapGameScreenshotResponsesToDomains(input: gameImages)
                result(.success(resultList))
            case .failure(let err):
                result(.failure(err))
            }
        }
    }
    
    func getFavoritedGames() -> AnyPublisher<[GameModel], Error> {
      return self.locale.getFavoritedGames()
        .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
        .eraseToAnyPublisher()
    }
    
    func addGameToFavorite(from game: GameModel) -> AnyPublisher<Bool, Error> {
        let game  = GameMapper.mapGameDomainToEntity(input: game)
        return self.locale.addGameToFavorite(from: game)
          .eraseToAnyPublisher()
    }
    
    func removeGameFromFavorite(from game: GameModel) -> AnyPublisher<Bool, Error> {
        let game  = GameMapper.mapGameDomainToEntity(input: game)
        return self.locale.removeGameFromFavorite(from: game)
          .eraseToAnyPublisher()
    }
}
