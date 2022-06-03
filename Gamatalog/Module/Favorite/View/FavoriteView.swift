//
//  FavoriteView.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 22/11/21.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter
    @State private var viewFavoriteGame: GameModel?
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Fetching Your Favorite Games ...")
                }
            } else {
                VStack {
                    Text("Your Favorite Games")
                        .font(.title.bold())
                        .padding()
                    
                    Divider()
                        .background(.white)
                        .frame(width: 120)
                        .padding(.bottom, 5)
                    
                    if presenter.favoritedGames.isEmpty {
                        VStack {
                            Text("You haven't favorite any games yet")
                            Text("Tap Heart Icon on Game Detail to favorite")
                        }
                    } else {
                        ScrollView(showsIndicators: false) {
                            ForEach(
                                self.presenter.favoritedGames,
                                id: \.id
                            ) { game in
                                ZStack {
                                    FavoriteGameCardView(game: game)
                                        .onTapGesture {
                                            viewFavoriteGame = game
                                        }
                                }
                            }
                        }
                        .padding(5)
                    }
                    Spacer()
                }
            }
        }
        .sheet(item: $viewFavoriteGame) { item in
          self.presenter.linkBuilder(for: item)
        }
        .onAppear {
            self.presenter.getGames()
        }
    }
}
