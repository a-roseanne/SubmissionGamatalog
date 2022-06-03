//
//  DetailPresenter.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var game: GameModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var gameDesc: String = ""
    @Published var gameScreenshots: [GameScreenshotModel] = []
    @Published var isLoading: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        game = detailUseCase.getGame()
    }
    
    func getGameDesc(gameId: Int) {
        detailUseCase.getGameDetail(gameId: gameId) { result in
        switch result {
        case .success(let gameDesc):
          DispatchQueue.main.async {
            self.gameDesc = gameDesc
          }
        case .failure(let error):
          DispatchQueue.main.async {
            self.loadingState = false
            self.errorMessage = error.localizedDescription
          }
        }
      }
    }
    
    func getGameScreenshots(gameId: Int) {
        detailUseCase.getGameScreenshot(gameId: gameId) { result in
        switch result {
        case .success(let gameScreenshots):
          DispatchQueue.main.async {
            self.gameScreenshots = gameScreenshots
          }
        case .failure(let error):
          DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
          }
        }
      }
    }
    
    func addToFav() {
        detailUseCase.addGameToFavorite()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
              switch completion {
              case .failure:
                self.errorMessage = String(describing: completion)
              case .finished:
                self.isLoading = false
              }
            }, receiveValue: { value in
              self.game.favorite = value
            })
            .store(in: &cancellables)
    }
    
    func deleteFromFav() {
        detailUseCase.removeGameFromFavorite()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
              switch completion {
              case .failure:
                self.errorMessage = String(describing: completion)
              case .finished:
                self.isLoading = false
              }
            }, receiveValue: { value in
              self.game.favorite = value
            })
            .store(in: &cancellables)
    }
}
