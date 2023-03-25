//
//  YourPictureView.swift
//  monti
//
//  Created by Andini Putri Pramudya Wardani on 24/03/23.
//

import SwiftUI
import BottomSheet

struct YourPictureView: View {
    
    @State var bottomSheetPosition: BottomSheetPosition = .relative(0.2)
    @State var searchText: String = ""
    
    var body: some View {
        ZStack{
            ContentView()
        }
        .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, switchablePositions: [
            .relative(0.2),
            .relativeTop(0.975)
        ], headerContent: {
            //A Title
            HStack {
                Text("Your Picture")
                    .font(.title.weight(.bold))
                    .multilineTextAlignment(.center)
            }
            .padding(EdgeInsets(top: 12, leading: 116, bottom: 12, trailing: 116))
        }) {
            HStack {
                Text("The picture you have taken will appear here.")
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        }
        .enableAppleScrollBehavior()
        .customBackground(
            Color("cream").cornerRadius(16)
        )
        
    }
}

struct YourPictureView_Previews: PreviewProvider {
    static var previews: some View {
        YourPictureView()
    }
}
