//
//  HomeInteractor.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getGameList() -> AnyPublisher<[GameModel], Error>
}

class HomeInteractor: HomeUseCase {
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGameList() -> AnyPublisher<[GameModel], Error> {
      return repository.getGameList()
    }
}
