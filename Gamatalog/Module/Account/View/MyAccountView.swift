//
//  MyAccountView.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 17/11/21.
//

import SwiftUI

struct MyAccountView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    Spacer()
                    Image("angel")
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .padding()
                    Text("Angelica Roseanne")
                        .font(.title2.bold())
                        .font(.body.bold())
                    Text("angelica_roseanne@ yahoo.co.id")
                        .font(.body.bold())
                    Spacer()
                }
            }
            .navigationBarTitle(Text("Account"))
        }
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
