//
//  HomeGameView.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import SwiftUI

struct HomeGameView: View {
    @ObservedObject var presenter: HomePresenter
    @ObservedObject var favPresenter: FavoritePresenter
    @State private var showProfileModal = false
    @State private var showFavoriteModal = false
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading Games ...")
                }
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(
                        self.presenter.games,
                        id: \.id
                    ) { game in
                        ZStack {
                            self.presenter.linkBuilder(for: game) {
                                GameCardView(game: game)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            if self.presenter.games.count == 0 {
                self.presenter.getGames()
            }
        }
        .navigationBarTitle(
            Text("Discover Games"),
            displayMode: .automatic
        )
        .sheet(isPresented: $showProfileModal) {
            MyAccountView()
        }
        .sheet(isPresented: $showFavoriteModal) {
            FavoriteView(presenter: favPresenter)
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    self.showFavoriteModal.toggle()
                } label: {
                Image(systemName: "heart")
                    .accentColor(Color("ProfileButton"))
                    .font(.title2)
                }
                Button {
                    self.showProfileModal.toggle()
                } label: {
                Image(systemName: "person.crop.circle")
                    .accentColor(Color("ProfileButton"))
                    .font(.title2)
                }
            }
        }
    }
}
