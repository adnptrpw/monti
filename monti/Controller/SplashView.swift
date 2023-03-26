//
//  SplashView.swift
//  monti
//
//  Created by Andini Putri Pramudya Wardani on 24/03/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var splashScreen = ""
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack{
            if self.isActive{
                ContentView()
            } else {
                VStack(alignment: .center){
                    Image(splashScreen)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .onAppear(perform: showMonti)
                }
            }
        } .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.36) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
    func showMonti(){
        
        var index = 0
        _ = Timer.scheduledTimer(withTimeInterval: 0.036, repeats: true){
            
            (Timer) in
            splashScreen = "main\(index)"
            index += 1
            
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
