//
//  ContentView.swift
//  monti
//
//  Created by Andini Putri Pramudya Wardani on 24/03/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Point your phone down at an empty space, and move it around slowly.").font(.title2).multilineTextAlignment(.center)
            Spacer()
//            TODO: Change into button and add action
            Label("Take a picture", systemImage: "camera").font(.title3.weight(.bold)).padding(EdgeInsets(top: 16, leading: 48, bottom: 16, trailing: 48)).background(Color("primary")).cornerRadius(1000)
        }.padding(EdgeInsets(top: 64, leading: 16, bottom: 64, trailing: 16))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
