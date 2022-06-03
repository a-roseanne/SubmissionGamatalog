//
//  FavoritePresenter.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 22/11/21.
//

import Combine
import SwiftUI

class FavoritePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()
    private let favUseCase: FavoriteUseCase
    
    @Published var favoritedGames: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(favoriteUseCase: FavoriteUseCase) {
      self.favUseCase = favoriteUseCase
    }
    
    func linkBuilder(
        for game: GameModel
    ) -> some View {
        return router.createDetailView(for: game)
    }
    
    // fav
    func getGames() {
      loadingState = true
      favUseCase.getFavoritedGame()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingState = false
          }
        }, receiveValue: { games in
          self.favoritedGames = games
        })
        .store(in: &cancellables)
    }
}
