//
//  GameCardView.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 17/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameCardView: View {
    var game: GameModel
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: game.backgroundImage))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 340, height: 320)
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(game.name)
                            .font(.title2.bold())
                        Spacer()
                    }
                    HStack {
                        Text(game.released)
                            .font(.headline)
                        Spacer()
                    }
                    
                }
                .frame(alignment: .leading)
                .padding()
                VStack {
                    Image(systemName: "star.fill")
                        .font(.title3)
                    Text("\(String(format: "%.1f", game.rating))")
                }
                .padding()
            }
            .foregroundColor(.white)
            .frame(width: 340)
        }
        .background(Color("PurpleAccent"))
        .cornerRadius(20)
        .frame(width: 340, height: 400)
    }
}
