//
//  ContentView.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 16/11/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    
    var body: some View {
        NavigationView {
            HomeGameView(presenter: homePresenter, favPresenter: favoritePresenter)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
