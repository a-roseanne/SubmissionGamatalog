//
//  HomeRouter.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import SwiftUI

class HomeRouter {
    func createDetailView(for game: GameModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(game: game)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailGameView(presenter: presenter)
    }
}
