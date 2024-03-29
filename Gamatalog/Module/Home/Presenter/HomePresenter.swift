//
//  HomePresenter.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
      self.homeUseCase = homeUseCase
    }
    
    func getGames() {
      loadingState = true
      homeUseCase.getGameList()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingState = false
          }
        }, receiveValue: { games in
          self.games = games
        })
        .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
      for game: GameModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
      destination: router.createDetailView(for: game)) { content() }
    }
}
