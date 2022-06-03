//
//  FavoriteRouter.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 22/11/21.
//

import SwiftUI

class FavoriteRouter {
    func createDetailView(for game: GameModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(game: game)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailGameView(presenter: presenter)
    }
}
