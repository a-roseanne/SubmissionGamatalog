//
//  DetailGameView.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 17/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
import URLImage

struct DetailGameView: View {
    @ObservedObject var presenter: DetailPresenter
    var scrWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            WebImage(url: URL(string: presenter.game.backgroundImage))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.size.width, height: 400)
                .cornerRadius(15)
                .ignoresSafeArea()
            
            VStack {
                // wishlist
                HStack {
                    Text(presenter.game.name)
                        .font(.title.bold())
                    Spacer()
                    Button(action: {
                        presenter.game.favorite.toggle()
                        if presenter.game.favorite {
                            presenter.addToFav()
                        } else {
                            presenter.deleteFromFav()
                        }
                    }) {
                        Image(systemName: presenter.game.favorite == true ? "heart.fill" : "heart")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .animation(.interpolatingSpring(stiffness: 120, damping: 5, initialVelocity: 5), value: 0.5)
                    }
                }
                
                Divider()
                    .background(.white)
                    .frame(width: scrWidth - 10)
                    .padding(.bottom)
                
                // screenshots
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(presenter.gameScreenshots) { gameSs in
                                URLImage(URL(string: gameSs.imgUrl)!) {image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 365, height: 225)
                                        .clipped()
                                        .cornerRadius(5.0)
                                }
                        }
                    }
                }
                
                // desc
                Group {
                    HStack {
                        Text("Description")
                            .font(.title2.bold())
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    Text(presenter.gameDesc)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding([.bottom, .horizontal])
                        .padding(.top, 4)
                }
                
                Divider()
                    .background(.white)
                    .frame(width: scrWidth - 10)
                    .padding(.bottom)
                
                // detail
                HStack(spacing: 10) {
                    Spacer()
                    HStack {
                        VStack {
                            Spacer()
                            Text("Rating")
                                .font(.footnote)
                            Spacer()
                            Label(
                                title: {
                                    Text("\(String(format: "%.1f", presenter.game.rating))")
                                },
                                icon: {
                                    Image(systemName: "star.fill")
                                }
                            )
                                .font(.body)
                            Spacer()
                        }
                    }
                    .frame(height: 70)
                    Spacer()
                    Divider()
                        .background(.white)
                        .frame(height: 40)
                    Spacer()
                    Group {
                        HStack {
                            VStack {
                                Spacer()
                                Text("Release Date")
                                    .font(.footnote)
                                Spacer()
                                Text("\(presenter.game.released)")
                                    .font(.body.bold())
                                Spacer()
                            }
                        }
                        .frame(height: 70)
                    }
                    Spacer()
                }
                .frame(width: scrWidth - 10, height: 80)
                Spacer()
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("PurpleAccent"))
            .cornerRadius(25)
            .foregroundColor(.white)
            .offset(y: -50)
            .onAppear {
                self.presenter.getGameDesc(gameId: presenter.game.id)
                self.presenter.getGameScreenshots(gameId: presenter.game.id)
            }
        }
    }
}
