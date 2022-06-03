//
//  FavoriteInteractor.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 22/11/21.
//

import Combine

protocol FavoriteUseCase {
    func getFavoritedGame() -> AnyPublisher<[GameModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoritedGame() -> AnyPublisher<[GameModel], Error> {
      return repository.getFavoritedGames()
    }
}
